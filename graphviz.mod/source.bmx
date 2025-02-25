SuperStrict

Import "../expat.mod/expat/lib/*.h"

Import "include/*.h"
Import "graphviz/*.h"

Import "graphviz/lib/*.h"
Import "graphviz/lib/graph/*.h"
Import "graphviz/lib/agraph/*.h"
Import "graphviz/lib/ast/*.h"
Import "graphviz/lib/cdt/*.h"
Import "graphviz/lib/cgraph/*.h"
Import "graphviz/lib/common/*.h"
Import "graphviz/lib/fdpgen/*.h"
Import "graphviz/lib/gvc/*.h"
Import "graphviz/lib/sfio/*.h"
Import "graphviz/lib/pathplan/*.h"
Import "graphviz/lib/agutil/*.h"
Import "graphviz/lib/vmalloc/*.h"
Import "graphviz/lib/circogen/*.h"
Import "graphviz/lib/neatogen/*.h"
Import "graphviz/lib/xdot/*.h"

Import "glue.c"
Import "builtins/dot_builtins.c"

' cdt
Import "graphviz/lib/cdt/dtclose.c"
Import "graphviz/lib/cdt/dtdisc.c"
Import "graphviz/lib/cdt/dtextract.c"
Import "graphviz/lib/cdt/dtflatten.c"
Import "graphviz/lib/cdt/dthash.c"
Import "graphviz/lib/cdt/dtlist.c"
Import "graphviz/lib/cdt/dtmethod.c"
Import "graphviz/lib/cdt/dtopen.c"
Import "graphviz/lib/cdt/dtrenew.c"
Import "graphviz/lib/cdt/dtrestore.c"
Import "graphviz/lib/cdt/dtsize.c"
Import "graphviz/lib/cdt/dtstat.c"
Import "graphviz/lib/cdt/dtstrhash.c"
Import "graphviz/lib/cdt/dttree.c"
Import "graphviz/lib/cdt/dtview.c"
Import "graphviz/lib/cdt/dtwalk.c"

' cgraph
Import "graphviz/lib/cgraph/acyclic.c"
Import "graphviz/lib/cgraph/agerror.c"
Import "graphviz/lib/cgraph/apply.c"
Import "graphviz/lib/cgraph/attr.c"
Import "graphviz/lib/cgraph/edge.c"
Import "graphviz/lib/cgraph/grammar.c"
Import "graphviz/lib/cgraph/graph.c"
Import "graphviz/lib/cgraph/id.c"
Import "graphviz/lib/cgraph/imap.c"
Import "graphviz/lib/cgraph/ingraphs.c"
Import "graphviz/lib/cgraph/io.c"
Import "graphviz/lib/cgraph/mem.c"
Import "graphviz/lib/cgraph/node_induce.c"
Import "graphviz/lib/cgraph/node.c"
Import "graphviz/lib/cgraph/obj.c"
Import "graphviz/lib/cgraph/rec.c"
Import "graphviz/lib/cgraph/refstr.c"
Import "graphviz/lib/cgraph/scan.c"
Import "graphviz/lib/cgraph/subg.c"
Import "graphviz/lib/cgraph/tred.c"
Import "graphviz/lib/cgraph/unflatten.c"
Import "graphviz/lib/cgraph/utils.c"
Import "graphviz/lib/cgraph/write.c"

' pathplan
Import "graphviz/lib/pathplan/cvt.c"
Import "graphviz/lib/pathplan/inpoly.c"
Import "graphviz/lib/pathplan/route.c"
Import "graphviz/lib/pathplan/shortest.c"
Import "graphviz/lib/pathplan/shortestpth.c"
Import "graphviz/lib/pathplan/solvers.c"
Import "graphviz/lib/pathplan/triang.c"
Import "graphviz/lib/pathplan/util.c"
Import "graphviz/lib/pathplan/visibility.c"

' util
Import "graphviz/lib/util/gv_fopen.c"

' gvc
Import "graphviz/lib/gvc/gvrender.c"
Import "graphviz/lib/gvc/gvlayout.c"
Import "graphviz/lib/gvc/gvdevice.c"
Import "graphviz/lib/gvc/gvloadimage.c"
Import "graphviz/lib/gvc/gvcontext.c"
Import "graphviz/lib/gvc/gvjobs.c"
Import "graphviz/lib/gvc/gvevent.c"
Import "graphviz/lib/gvc/gvplugin.c"
Import "graphviz/lib/gvc/gvconfig.c"
Import "graphviz/lib/gvc/gvtextlayout.c"
Import "graphviz/lib/gvc/gvusershape.c"
Import "graphviz/lib/gvc/gvc.c"

'Import "graphviz/lib/gvc/dot_builtins.c" ' BUILT INS !!!

' common
Import "graphviz/lib/common/args.c"
Import "graphviz/lib/common/arrows.c"
Import "graphviz/lib/common/colxlate.c"
Import "graphviz/lib/common/ellipse.c"
Import "graphviz/lib/common/emit.c"
Import "graphviz/lib/common/geom.c"
Import "graphviz/lib/common/globals.c"
Import "graphviz/lib/common/htmllex.c"
Import "graphviz/lib/common/htmlparse.c"
Import "graphviz/lib/common/htmltable.c"
Import "graphviz/lib/common/input.c"
Import "graphviz/lib/common/labels.c"
Import "graphviz/lib/common/ns.c"
Import "graphviz/lib/common/output.c"
Import "graphviz/lib/common/pointset.c"
Import "graphviz/lib/common/postproc.c"
Import "graphviz/lib/common/psusershape.c"
Import "graphviz/lib/common/routespl.c"
Import "graphviz/lib/common/shapes.c"
Import "graphviz/lib/common/splines.c"
Import "graphviz/lib/common/taper.c"
Import "graphviz/lib/common/textspan_lut.c"
Import "graphviz/lib/common/textspan.c"
Import "graphviz/lib/common/timing.c"
Import "graphviz/lib/common/common_utils.c" ' renamed from utils.c
Import "graphviz/lib/common/xml.c"

' plugin
Import "graphviz/plugin/core/gvloadimage_core.c"
Import "graphviz/plugin/core/gvplugin_core.c"
Import "graphviz/plugin/core/gvrender_core_dot.c"
Import "graphviz/plugin/core/gvrender_core_fig.c"
Import "graphviz/plugin/core/gvrender_core_json.c"
Import "graphviz/plugin/core/gvrender_core_map.c"
Import "graphviz/plugin/core/gvrender_core_pic.c"
Import "graphviz/plugin/core/gvrender_core_pov.c"
Import "graphviz/plugin/core/gvrender_core_ps.c"
Import "graphviz/plugin/core/gvrender_core_svg.c"
Import "graphviz/plugin/core/gvrender_core_tk.c"


Import "graphviz/plugin/dot_layout/gvplugin_dot_layout.c"
Import "graphviz/plugin/dot_layout/gvlayout_dot_layout.c"

Import "graphviz/plugin/neato_layout/gvplugin_neato_layout.c"
Import "graphviz/plugin/neato_layout/gvlayout_neato_layout.c"


' circogen
Import "graphviz/lib/circogen/block.c"
Import "graphviz/lib/circogen/blockpath.c"
Import "graphviz/lib/circogen/blocktree.c"
Import "graphviz/lib/circogen/circpos.c"
Import "graphviz/lib/circogen/circular.c"
Import "graphviz/lib/circogen/circularinit.c"
Import "graphviz/lib/circogen/edgelist.c"
Import "graphviz/lib/circogen/nodelist.c"

' dotgen
Import "graphviz/lib/dotgen/acyclic.c"
Import "graphviz/lib/dotgen/aspect.c"
Import "graphviz/lib/dotgen/class1.c"
Import "graphviz/lib/dotgen/class2.c"
Import "graphviz/lib/dotgen/cluster.c"
Import "graphviz/lib/dotgen/compound.c"
Import "graphviz/lib/dotgen/conc.c"
Import "graphviz/lib/dotgen/decomp.c"
Import "graphviz/lib/dotgen/fastgr.c"
Import "graphviz/lib/dotgen/flat.c"
Import "graphviz/lib/dotgen/dotinit.c"
Import "graphviz/lib/dotgen/mincross.c"
Import "graphviz/lib/dotgen/position.c"
Import "graphviz/lib/dotgen/rank.c"
Import "graphviz/lib/dotgen/sameport.c"
Import "graphviz/lib/dotgen/dotsplines.c"

' fdpgen
Import "graphviz/lib/fdpgen/comp.c"
Import "graphviz/lib/fdpgen/dbg.c"
Import "graphviz/lib/fdpgen/grid.c"
Import "graphviz/lib/fdpgen/fdpinit.c"
Import "graphviz/lib/fdpgen/layout.c"
Import "graphviz/lib/fdpgen/tlayout.c"
Import "graphviz/lib/fdpgen/xlayout.c"
Import "graphviz/lib/fdpgen/clusteredges.c"

' neatogen
Import "graphviz/lib/neatogen/adjust.c"
Import "graphviz/lib/neatogen/bfs.c"
Import "graphviz/lib/neatogen/call_tri.c"
Import "graphviz/lib/neatogen/circuit.c"
Import "graphviz/lib/neatogen/closest.c"
Import "graphviz/lib/neatogen/compute_hierarchy.c"
Import "graphviz/lib/neatogen/conjgrad.c"
Import "graphviz/lib/neatogen/constrained_majorization_ipsep.c"
Import "graphviz/lib/neatogen/constrained_majorization.c"
Import "graphviz/lib/neatogen/constraint.c"
Import "graphviz/lib/neatogen/delaunay.c"
Import "graphviz/lib/neatogen/dijkstra.c"
Import "graphviz/lib/neatogen/edges.c"
Import "graphviz/lib/neatogen/embed_graph.c"
Import "graphviz/lib/neatogen/geometry.c"
Import "graphviz/lib/neatogen/heap.c"
Import "graphviz/lib/neatogen/hedges.c"
Import "graphviz/lib/neatogen/info.c"
Import "graphviz/lib/neatogen/kkutils.c"
Import "graphviz/lib/neatogen/legal.c"
Import "graphviz/lib/neatogen/lu.c"
Import "graphviz/lib/neatogen/matinv.c"
Import "graphviz/lib/neatogen/matrix_ops.c"
Import "graphviz/lib/neatogen/memory.c"
Import "graphviz/lib/neatogen/multispline.c"
Import "graphviz/lib/neatogen/neatoinit.c"
Import "graphviz/lib/neatogen/neatosplines.c"
Import "graphviz/lib/neatogen/opt_arrangement.c"
Import "graphviz/lib/neatogen/overlap.c"
Import "graphviz/lib/neatogen/pca.c"
Import "graphviz/lib/neatogen/poly.c"
Import "graphviz/lib/neatogen/quad_prog_solve.c"
Import "graphviz/lib/neatogen/quad_prog_vpsc.c"
Import "graphviz/lib/neatogen/randomkit.c"
Import "graphviz/lib/neatogen/sgd.c"
Import "graphviz/lib/neatogen/site.c"
Import "graphviz/lib/neatogen/smart_ini_x.c"
Import "graphviz/lib/neatogen/solve.c"
Import "graphviz/lib/neatogen/stress.c"
Import "graphviz/lib/neatogen/stuff.c"
Import "graphviz/lib/neatogen/voronoi.c"

' pack
Import "graphviz/lib/pack/ccomps.c"
Import "graphviz/lib/pack/pack.c"

' sfio
Import "graphviz/lib/sfio/sfcvt.c"
Import "graphviz/lib/sfio/sfextern.c"
Import "graphviz/lib/sfio/sfprint.c"
Import "graphviz/lib/sfio/sftable.c"
Import "graphviz/lib/sfio/sfvscanf.c"

' twopigen
Import "graphviz/lib/twopigen/twopiinit.c"
Import "graphviz/lib/twopigen/circle.c"

' vmalloc
Import "graphviz/lib/vmalloc/vmalloc.c"
Import "graphviz/lib/vmalloc/vmclear.c"
Import "graphviz/lib/vmalloc/vmclose.c"
Import "graphviz/lib/vmalloc/vmopen.c"
Import "graphviz/lib/vmalloc/vmstrdup.c"

' xdot
Import "graphviz/lib/xdot/xdot.c"

' sparse
Import "graphviz/lib/sparse/clustering.c"
Import "graphviz/lib/sparse/color_palette.c"
Import "graphviz/lib/sparse/colorutil.c"
Import "graphviz/lib/sparse/DotIO.c"
Import "graphviz/lib/sparse/general.c"
Import "graphviz/lib/sparse/mq.c"
Import "graphviz/lib/sparse/QuadTree.c"
Import "graphviz/lib/sparse/SparseMatrix.c"

' osage
Import "graphviz/lib/osage/osageinit.c"

' patchwork
Import "graphviz/lib/patchwork/patchwork.c"
Import "graphviz/lib/patchwork/patchworkinit.c"
Import "graphviz/lib/patchwork/tree_map.c"

' label
Import "graphviz/lib/label/index.c"
Import "graphviz/lib/label/node.c"
Import "graphviz/lib/label/rectangle.c"
Import "graphviz/lib/label/split.q.c"
Import "graphviz/lib/label/xlabels.c"

' ortho
Import "graphviz/lib/ortho/fPQ.c"
Import "graphviz/lib/ortho/maze.c"
Import "graphviz/lib/ortho/ortho.c"
Import "graphviz/lib/ortho/partition.c"
Import "graphviz/lib/ortho/rawgraph.c"
Import "graphviz/lib/ortho/sgraph.c"
Import "graphviz/lib/ortho/trapezoid.c"

' sfdpgen
Import "graphviz/lib/sfdpgen/Multilevel.c"
Import "graphviz/lib/sfdpgen/post_process.c"
Import "graphviz/lib/sfdpgen/sfdpinit.c"
Import "graphviz/lib/sfdpgen/sparse_solve.c"
Import "graphviz/lib/sfdpgen/spring_electrical.c"
Import "graphviz/lib/sfdpgen/stress_model.c"

?macos
Import "graphviz/plugin/quartz/gvdevice_quartz.c"
Import "graphviz/plugin/quartz/gvloadimage_quartz.c"
Import "graphviz/plugin/quartz/gvplugin_quartz.c"
Import "graphviz/plugin/quartz/gvrender_quartz.c"
Import "graphviz/plugin/quartz/gvtextlayout_quartz.c"
Import "graphviz/plugin/quartz/GVTextLayout.m"
?
