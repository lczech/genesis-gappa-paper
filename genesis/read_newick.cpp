/*
    Genesis - A toolkit for working with phylogenetic data.
    Copyright (C) 2014-2017 Lucas Czech

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

    Contact:
    Lucas Czech <lucas.czech@h-its.org>
    Exelixis Lab, Heidelberg Institute for Theoretical Studies
    Schloss-Wolfsbrunnenweg 35, D-69118 Heidelberg, Germany
*/

#include "genesis/genesis.hpp"

#include <fstream>
#include <string>
#include <unordered_map>
#include <vector>
#include <ctime>

using namespace genesis;
using namespace genesis::tree;

int main( int argc, char** argv )
{
    // Check if the command line contains the right number of arguments.
    if (argc != 2) {
        throw std::runtime_error(
            "Need to provide a newick tree file.\n"
        );
    }

    using namespace std;

    // Activate logging.
    utils::Logging::log_to_stdout();
    utils::Logging::details.time = true;
    LOG_INFO << "Started " << utils::current_time();

    auto newick_path = std::string( argv[1] );

    LOG_TIME << "Start reading";
    clock_t begin = clock();
    auto tree = CommonTreeNewickReader().read( utils::from_file( newick_path ));
    LOG_TIME << "Finished Reading " << utils::current_time();
    clock_t end = clock();
    double elapsed_secs = double(end - begin) / CLOCKS_PER_SEC;
    LOG_BOLD << "Internal time: " << elapsed_secs << "\n";
    // LOG_INFO << "Finished Reading " << utils::current_time();

    // LOG_DBG << "root node rank " << tree.root_node().rank();

    // LOG_INFO << "Rooted:      " << ( is_rooted( tree ) ? "yes" : "no");
    // LOG_INFO << "Bifurcating: " << ( is_bifurcating( tree ) ? "yes" : "no");
    // LOG_INFO << "Edges:       " << tree.edge_count();
    // LOG_INFO << "Nodes:       " << tree.node_count();
    // LOG_INFO << "Leaves:      " << leaf_node_count( tree );
    // LOG_INFO << "Length:      " << length( tree ) << " (sum of all branch lengths)";
    // LOG_INFO << "Height:      " << height( tree ) << " (longest distance from root to a leaf)";
    // LOG_INFO << "Diameter:    " << diameter( tree ) << " (longest distance between any two nodes)";

    // for( auto& node : tree.nodes() ) {
    //     auto& name = node->data<DefaultNodeData>().name;
    //     name = utils::replace_all_chars( name, " :;()[],", '_' );
        // auto const pos = name.find_first_of( "'" );
        // if( pos != std::string::npos ) {
        //     name = name.substr( 0, pos );
        // }
    // }

    // LOG_DBG << "write";
    // DefaultTreeNewickWriter().to_file( tree, newick_path + ".new" );

    LOG_INFO << "Finished " << utils::current_time();
    return 0;
}
