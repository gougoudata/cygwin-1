<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

<!--############################################################################
    XSLT Stylesheet DocBook -> LaTeX 
    ############################################################################ -->

<!-- Figure parameters -->
<xsl:param name="figure.title.top">0</xsl:param>
<xsl:param name="figure.default.position">[htbp]</xsl:param>


<xsl:template match="figure">
  <xsl:text>\begin{figure}</xsl:text>
  <!-- figure placement preference -->
  <xsl:choose>
    <xsl:when test="@floatstyle != ''">
      <xsl:value-of select="@floatstyle"/>
    </xsl:when>
    <xsl:when test="not(@float) or (@float and @float='0')">
      <xsl:text>[H]</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$figure.default.position"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:text>&#10;</xsl:text>
  <!-- title caption before the image -->
  <xsl:if test="$figure.title.top = '1'">
    <xsl:apply-templates select="title"/>
  </xsl:if>
  <!--
  <xsl:text>&#10;\centering&#10;</xsl:text>
  -->
  <xsl:text>&#10;\begin{center}&#10;</xsl:text>
  <xsl:apply-templates select="*[not(self::title)]"/>
  <xsl:text>&#10;\end{center}&#10;</xsl:text>
  <!-- title caption after the image -->
  <xsl:if test="$figure.title.top != '1'">
    <xsl:apply-templates select="title"/>
  </xsl:if>
  <xsl:text>\end{figure}&#10;</xsl:text>
</xsl:template>

<xsl:template match="informalfigure">
  <xsl:text>&#10;\begin{center}&#10;</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>&#10;\end{center}&#10;</xsl:text>
</xsl:template>

<xsl:template match="figure/title">
  <xsl:text>\caption</xsl:text>
  <xsl:apply-templates select="." mode="format.title"/>
  <xsl:call-template name="label.id">
    <xsl:with-param name="object" select="parent::figure"/>
  </xsl:call-template>
</xsl:template>

</xsl:stylesheet>

