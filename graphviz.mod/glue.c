
#include "config.h"
#include "gvc/gvc.h"
#include "cgraph/cgraph.h"

GVC_t * bmx_gvc_new() {
    return gvContextPlugins(lt_preloaded_symbols, 0);
}

void bmx_graphviz_unflatten(Agraph_t * g, int doFans, int maxMinlen, int chainLimit) {
    graphviz_unflatten_options_t opts = {doFans, maxMinlen, chainLimit};
    graphviz_unflatten(g, &opts);
}
