#if !defined(GDK_PIXBUF_DISABLE_DEPRECATED) || defined(GDK_PIXBUF_COMPILATION)

#ifndef ___gdk_pixbuf_marshal_MARSHAL_H__
#define ___gdk_pixbuf_marshal_MARSHAL_H__

#include	<glib-object.h>

G_BEGIN_DECLS

/* VOID:VOID (/usr/src/ports/gdk-pixbuf2.0/gdk-pixbuf2.0-2.26.5-1/src/gdk-pixbuf-2.26.5/gdk-pixbuf/gdk-pixbuf-marshal.list:25) */
#define _gdk_pixbuf_marshal_VOID__VOID	g_cclosure_marshal_VOID__VOID

/* VOID:INT,INT (/usr/src/ports/gdk-pixbuf2.0/gdk-pixbuf2.0-2.26.5-1/src/gdk-pixbuf-2.26.5/gdk-pixbuf/gdk-pixbuf-marshal.list:26) */
extern void _gdk_pixbuf_marshal_VOID__INT_INT (GClosure     *closure,
                                               GValue       *return_value,
                                               guint         n_param_values,
                                               const GValue *param_values,
                                               gpointer      invocation_hint,
                                               gpointer      marshal_data);

/* VOID:INT,INT,INT,INT (/usr/src/ports/gdk-pixbuf2.0/gdk-pixbuf2.0-2.26.5-1/src/gdk-pixbuf-2.26.5/gdk-pixbuf/gdk-pixbuf-marshal.list:27) */
extern void _gdk_pixbuf_marshal_VOID__INT_INT_INT_INT (GClosure     *closure,
                                                       GValue       *return_value,
                                                       guint         n_param_values,
                                                       const GValue *param_values,
                                                       gpointer      invocation_hint,
                                                       gpointer      marshal_data);

/* VOID:POINTER (/usr/src/ports/gdk-pixbuf2.0/gdk-pixbuf2.0-2.26.5-1/src/gdk-pixbuf-2.26.5/gdk-pixbuf/gdk-pixbuf-marshal.list:28) */
#define _gdk_pixbuf_marshal_VOID__POINTER	g_cclosure_marshal_VOID__POINTER

G_END_DECLS

#endif /* ___gdk_pixbuf_marshal_MARSHAL_H__ */

#endif /* !GDK_PIXBUF_DISABLE_DEPRECATED || GDK_PIXBUF_COMPILATION */