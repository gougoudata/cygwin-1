import sys
import os
import re
import shutil
import logging
import urllib
from dbtexmf.core.error import signal_error

#
# Objects to convert an image format to another. Actually use the underlying
# tools.
#
class ImageConverter:
    def __init__(self):
        self.debug = 1
        self.log = None
        self.fake = 0

    def system(self, cmd, doexec=1):
        if not(cmd):
            return ""
        if self.log:
            self.log.info(cmd)
        if doexec:
            if not(self.fake):
                if (os.system(cmd)):
                    signal_error(self, cmd)
        else:
            return cmd

    def convert(self, input, output, format, doexec=1):
        pass


class GifConverter(ImageConverter):
    def convert(self, input, output, format, doexec=1):
        cmd = "convert \"%s\" %s" % (input, output)
        return self.system(cmd, doexec)

class EpsConverter(ImageConverter):
    def convert(self, input, output, format, doexec=1):
        if format == "pdf":
            cmd = "epstopdf --outfile=%s \"%s\"" % (output, input)
        elif format == "png":
            cmd = "convert \"%s\" %s" % (input, output)
        else:
            cmd = ""
        return self.system(cmd, doexec)

class FigConverter(ImageConverter):
    def convert(self, input, output, format, doexec=1):
        if (format != "eps"):
            conv = EpsConverter()
            conv.fake = self.fake
            conv.log = self.log
            epsfile = "tmp_fig.eps"
            post = " && "
            post += conv.convert(epsfile, output, format, doexec=0)
        else:
            post = ""
            epsfile = output

        cmd = "fig2dev -L eps \"%s\" > %s" % (input, epsfile)
        cmd += post
        self.system(cmd)

class SvgConverter(ImageConverter):
    def convert(self, input, output, format, doexec=1):
        cmd = "inkscape -z -D --export-%s=%s \"%s\"" % (format, output, input)
        return self.system(cmd, doexec)


#
# The Imagedata class handles all the image transformation
# process, from the discovery of the actual image involved to
# the conversion process.
#
class Imagedata:
    def __init__(self):
        self.paths = []
        self.input_format = "png"
        self.output_format = "pdf"
        self.converted = {}
        self.log = logging.getLogger("dblatex")
        self.output_encoding = ""

    def set_encoding(self, output_encoding):
        self.output_encoding = output_encoding

    def convert(self, fig):
        # Translate the URL to an actual local path
        fig = urllib.url2pathname(fig)

        # First, scan the available formats
        (realfig, ext) = self.scanformat(fig)

        # No real file found, give up
        if not(realfig):
            self.log.warning("Image '%s' not found" % fig)
            return fig

        # Check if this image has been already converted
        if self.converted.has_key(realfig):
            self.log.info("Image '%s' already converted as %s" % \
                  (fig, self.converted[realfig]))
            return self.converted[realfig]

        # No format found, take the default one
        if not(ext):
            ext = self.input_format

        # Natively supported format?
        if (ext == self.output_format):
            return self._safe_file(fig, realfig, ext)

        # Try to convert
        count = len(self.converted)
        newfig = "fig%d.%s" % (count, self.output_format)

        if (ext == "fig" and self.output_format in ("eps", "pdf", "png")):
            conv = FigConverter()
        elif (ext == "svg" and self.output_format in ("eps", "pdf", "png")):
            conv = SvgConverter()
        elif (ext == "eps"):
            conv = EpsConverter()
        elif (ext in ("gif", "bmp")):
            conv = GifConverter()
        else:
            # Unknown conversion to do, or nothing to do
            return self._safe_file(fig, realfig, ext)

        # Convert the image and put it in the cache
        conv.log = self.log
        conv.convert(realfig, newfig, self.output_format)
        self.converted[realfig] = newfig
        return newfig

    def _safe_file(self, fig, realfig, ext):
        """
        Copy the file in the working directory if its path contains characters
        unsupported by latex, like spaces.
        """
        # Encode to expected output format. If encoding is OK and 
        # supported by tex, just return the encoded path
        newfig = self._path_encode(fig)
        if newfig and newfig.find(" ") == -1:
            return newfig

        # Added to the converted list
        count = len(self.converted)
        newfig = "figcopy%d.%s" % (count, ext)
        self.converted[realfig] = newfig

        # Do the copy
        shutil.copyfile(realfig, newfig)
        return newfig

    def _path_encode(self, fig):
        # Actually, only ASCII characters are sure to match filesystem encoding
        # so let's be conservative
        if self.output_encoding == "utf8":
            return fig
        try:
            newfig = fig.decode("utf8").encode("ascii")
        except:
            newfig = ""
        return newfig

    def scanformat(self, fig):
        (root, ext) = os.path.splitext(fig)

        if (ext):
            realfig = self.find(fig)
            return (realfig, ext[1:])
        
        # Lookup for the best suited available figure
        if (self.output_format == "pdf"):
            formats = ("png", "pdf", "jpg", "eps", "gif", "fig", "svg")
        else:
            formats = ("eps", "fig", "pdf", "png", "svg")

        for format in formats:
            realfig = self.find("%s.%s" % (fig, format))
            if realfig:
                self.log.info("Found %s for '%s'" % (format, fig))
                break

        # Maybe a figure with no extension
        if not(realfig):
            realfig = self.find(fig)
            format = ""

        return (realfig, format)
        
    def find(self, fig):
        # First, the obvious absolute path case
        if os.path.isabs(fig):
            if os.path.isfile(fig):
                return fig
            else:
                return None

        # Then, look for the file in known paths
        for path in self.paths:
            realfig = os.path.join(path, fig)
            if os.path.isfile(realfig):
                return realfig

        return None
       
    def system(self, cmd):
        self.log.info(cmd)
        rc = os.system(cmd)
        # TODO: raise error when system call failed

