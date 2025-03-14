# author: 
# date: 2025-03-13
# template copied from IA4

# this section need to be changed
all: results/horse_pop_plot_largest_sd.png \
	results/horse_pops_plot.png \
	results/horses_spread.csv \

	reports/analysis.html \
	reports/analysis.pdf



# generate figures and objects for report
# figures need to be changed
results/horse_pop_plot_largest_sd.png results/horse_pops_plot.png results/horses_spread.csv: source/generate_figures.R
	Rscript source/generate_figures.R --input_dir="data/00030067-eng.csv" \
		--out_dir="results"

# render quarto report in HTML and PDF
#this section is probably done

reports/analysis.html: results reports/analysis.qmd
	quarto render reports/analysis.qmd --to html

reports/analysis.pdf: results reports/analysis.qmd
	quarto render reports/analysis.qmd --to pdf


# clean
#this section is probably done
clean:
	rm -rf results
	rm -rf reports/analysis.html \
		reports/analysis.pdf \


		reports/qmd_example_files
#this last line was copied from IA4 not sure if it is good here