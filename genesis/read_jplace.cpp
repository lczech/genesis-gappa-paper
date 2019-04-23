/*
    Genesis - A toolkit for working with phylogenetic data.
    Copyright (C) 2014-2019 Lucas Czech and HITS gGmbH

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


using namespace genesis;
using namespace genesis::placement;

int main( int argc, char** argv )
{
    // Check if the command line contains the right number of arguments.
    if (argc != 2) {
        throw std::runtime_error(
            "Need to provide a jplace file.\n"
        );
    }

    using namespace std;

    // Activate logging.
    utils::Logging::log_to_stdout();
    utils::Logging::details.time = true;
    LOG_INFO << "Started " << utils::current_time();

    auto jplace_path = std::string( argv[1] );

    LOG_TIME << "Start reading";
    clock_t begin = clock();

    auto const sample = JplaceReader().read( utils::from_file( jplace_path ));

    clock_t end = clock();
    double elapsed_secs = double(end - begin) / CLOCKS_PER_SEC;
    LOG_TIME << "Finished Reading " << utils::current_time();
    LOG_BOLD << "Internal time: " << elapsed_secs << "\n";

    LOG_INFO << "size " << sample.size();

    LOG_INFO << "Finished " << utils::current_time();
    return 0;
}
