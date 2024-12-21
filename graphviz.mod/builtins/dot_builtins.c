
#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "gvplugin.h"

extern gvplugin_library_t *gvplugin_dot_layout_LTX_library;
extern gvplugin_library_t *gvplugin_neato_layout_LTX_library;
#ifdef HAVE_LIBGD
extern gvplugin_library_t *gvplugin_gd_LTX_library;
#endif
#ifdef HAVE_PANGOCAIRO
extern gvplugin_library_t *gvplugin_pango_LTX_library;
#endif
#ifdef __APPLE__
extern gvplugin_library_t *gvplugin_quartz_LTX_library;
#endif
extern gvplugin_library_t *gvplugin_core_LTX_library;

lt_symlist_t lt_preloaded_symbols[] = {
	{ "gvplugin_dot_layout_LTX_library", (void*)(&gvplugin_dot_layout_LTX_library) },
	{ "gvplugin_neato_layout_LTX_library", (void*)(&gvplugin_neato_layout_LTX_library) },
#ifdef HAVE_PANGOCAIRO
	{ "gvplugin_pango_LTX_library", (void*)(&gvplugin_pango_LTX_library) },
#endif
#ifdef HAVE_LIBGD
	{ "gvplugin_gd_LTX_library", (void*)(&gvplugin_gd_LTX_library) },
#endif
#ifdef __APPLE__
	{ "gvplugin_quartz_LTX_library", (void*)(&gvplugin_quartz_LTX_library) },
#endif
	{ "gvplugin_core_LTX_library", (void*)(&gvplugin_core_LTX_library) },
	{ 0, 0 }
};
