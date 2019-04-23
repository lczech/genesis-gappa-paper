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

#include <array>
#include <fstream>
#include <string>
#include <map>
#include <ctime>

using namespace genesis;
using namespace genesis::sequence;
using namespace genesis::utils;

int main( int argc, char** argv )
{
    // Activate logging.
    utils::Logging::log_to_stdout();
    utils::Logging::details.time = true;

    utils::Options::get().number_of_threads( 4 );
    // LOG_BOLD << utils::Options::get().info();
    // LOG_BOLD;

    if (argc != 2) {
        throw std::runtime_error(
            "Need to provide a fasta file.\n"
        );
    }
	auto const infile = std::string( argv[1] );

    auto freqs = std::array<size_t, 256>{};
    for( size_t i = 0; i < freqs.size(); ++i ) {
        freqs[i] = 0;
    }

    LOG_INFO << "Started";
    LOG_TIME << "now";
    clock_t begin = clock();

    auto it = FastaInputIterator( from_file( infile ));
    size_t cnt = 0;
    while( it ) {
        for( auto& c : *it ) {
            ++freqs[c];
        }
        ++cnt;
        ++it;
    }

    clock_t end = clock();
    LOG_TIME << "then";
    LOG_INFO << "Found " << cnt << " sequences.";

    double elapsed_secs = double(end - begin) / CLOCKS_PER_SEC;
    LOG_BOLD << "Internal time: " << elapsed_secs << "\n";

    LOG_INFO << "G " << ( freqs['g'] + freqs['G'] );
    LOG_INFO << "C " << ( freqs['c'] + freqs['C'] );
    LOG_INFO << "A " << ( freqs['a'] + freqs['A'] );
    LOG_INFO << "U " << ( freqs['u'] + freqs['U'] );
    LOG_INFO << "- " << ( freqs['-'] + freqs['.'] );

    LOG_INFO << "Finished";
    return 0;
}
