#!/usr/bin/python

# libraries
import matplotlib
matplotlib.use('TkAgg')

import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import numpy as np
import pandas as pd
import seaborn as sns
import os

# Create dirs for results
if not os.path.exists("figures_png"):
    os.makedirs("figures_png")
if not os.path.exists("figures_svg"):
    os.makedirs("figures_svg")

# Read data
tmr_file = "measure_time.csv"
mem_file = "measure_memory.csv"
tmr_data = pd.read_csv( tmr_file, sep="\t", header=None ) #, index_col=0 )
mem_data = pd.read_csv( mem_file, sep="\t", header=None ) #, index_col=0 )
#print tmr_data
#print mem_data

# Types of test that we have
testnames = [ "read_fasta", "read_phylip", "base_frequencies", "read_newick", "pairwise_patristic", "read_jplace" ]
#testnames = [  "pairwise_patristic" ]

# Prepare fixed colors for each tool
line_colors = {
	"genesis": "k",
	"biopython": "C2",
	"ape": "C1",
	"dendropy": "C0",
	"ete3": "C6",
	"ggtree": "C4",
	"guppy": "C7",
	"libpll": "C5",
	"scikit-bio": "C3"
}

plotnum = 1
def plot_test(testname, data, measure):
	global plotnum
	
	# For one test, we only use part of the data.
	# It's too big for a full run.
	if testname == "pairwise_patristic":
		max_x = 4
	else:
		max_x = 10
	title = ' '.join(''.join([w[0].upper(), w[1:].lower()]) for w in testname.split("_"))
	if measure == "tmr":
		title += "  " + "(Runtime)"
	else:
		title += "  " + "(Memory)"
	
	# Make a new dataframe with just the needed content.
	sub_data = pd.DataFrame()
	line_styles = list()
	for index, row in data.loc[data[0].str.contains(testname)].iterrows():
		name = row[0].split("/")[0]
		data = row[1:max_x+1] 
		data = list(row[1:max_x+1])
		sub_data[name] = data
		
		# Make a special style for genesis: solid line at the front of the list,
		# because we are going to move the genesis column to the front as well.
		# All other tools get a dashed line.
		if name == "genesis":
			line_styles.insert(0, "")
		else:
			line_styles.append((5,2))
	
	# Move genesis column to front. It's the one we are interested in here.
	cols = list(sub_data)
	cols.insert(0, cols.pop(cols.index('genesis')))
	sub_data = sub_data.ix[:, cols]
	
	# Rename the rows. Nope, this confuses seaborn. Store row names instead, use them later.
	size_names = ['1K', '2K', '5K', '10K', '20K', '50K', '100K', '200K', '500K', '1M']
	size_names = size_names[0:max_x]
	#idx_rename = { 1:'1k', 2:'2k', 3:'5k', 4:'10k', 5:'20k', 6:'50k', 7:'100k', 8:'200k', 9:'500k', 10:'1m' }
	#sub_data = pd.DataFrame(columns = size_names)
	#sub_data = sub_data.rename( index=idx_rename )
	#print sub_data
	
	# Make the plot. Our data set sizes are roughly exponential,
	# so the x-axis already is kind of log scaled. Do the same for the y-axis.
	plt.figure( plotnum )
	ax = sns.lineplot( data=sub_data, marker="o", dashes=line_styles, palette=line_colors ) #dashes=False, 
	ax.set_yscale('log')
	ax.yaxis.grid(True, which='major')
	plt.tight_layout()
	
	# Nameing the plot and the axis.
	ax.set_title( title )
	#ax.set_xlabel('Dataset Size  [bytes]')
	if testname == "read_fasta" or testname == "read_phylip" or testname == "base_frequencies":
		ax.set_xlabel('Dataset Size  [sequences]')
	elif testname == "read_newick" or testname == "pairwise_patristic":
		ax.set_xlabel('Dataset Size  [taxa]')
	elif testname == "read_jplace":
		ax.set_xlabel('Dataset Size  [queries]')
	else:
		ax.set_xlabel('Dataset Size')
	if measure == "tmr":
		ax.set_ylabel('Runtime  [s]')
	else:
		ax.set_ylabel('Memory  [MB]')
	
	# Set correct x axis labels. Nightmare.
	ax.set_xticks(list(), minor=False)
	ax.set_xticklabels('', minor=False)
	ax.set_xticks(list(range(max_x)), minor=True)
	ax.set_xticklabels(size_names, minor=True)
	#ax.xaxis.grid(False, which='minor')
	
	# Save to files
	plt.savefig("figures_png/" + measure + "_" + testname + ".png", format='png')
	plt.savefig("figures_svg/" + measure + "_" + testname + ".svg", format='svg')
	plt.close( plotnum )
	plotnum += 1

for testname in testnames:
	print "Running", testname
	
	plot_test(testname, tmr_data, "tmr")
	plot_test(testname, mem_data, "mem")

	
