# author: 
# date: 2025-03-13
# template copied from IA4

all: data/data.xls data/clean/data.xls \
	results/table1.csv results/table2.csv results/table3.csv results/table4.csv results/table5.csv \
	results/table6.txt results/table7.txt results/fig2.png results/fig3.png \
	reports/student_exam_performance.html \
	reports/student_exam_performance.pdf

# generate figures and objects for report

data/data.xls: scripts/01_load.R
	mkdir -p data
	mkdir -p results
	Rscript scripts/01_load.R --url="https://archive.ics.uci.edu/ml/machine-learning-databases/00257/Data_User_Modeling_Dataset_Hamdi%20Tolga%20KAHRAMAN.xls" \
		--output_path="./data/data.xls"

data/clean/data.xls: scripts/02_read-clean.R
	mkdir -p data/clean
	Rscript scripts/02_read-clean.R --file_path="./data/data.xls" \
		--output_path="./data/clean/data.xls"

results/table1.csv results/table2.csv results/table3.csv results/table4.csv results/table5.csv: scripts/03_eda.R
	Rscript scripts/03_eda.R --file_path="./data/clean/data.xls" \
		--table1="./results/table1.csv" \
		--table2="./results/table2.csv" \
		--table3="./results/table3.csv" \
		--table4="./results/table4.csv" \
		--table5="./results/table5.csv" \
		--fig1="./results/fig1.png"

results/table6.txt results/table7.txt results/fig2.png results/fig3.png: scripts/04_modelling.R
	Rscript scripts/04_modelling.R --file_path="./data/clean/data.xls" \
		--table6="./results/table6.txt" \
		--table7="./results/table7.txt" \
		--fig2="./results/fig2.png" \
		--fig3="./results/fig3.png"

# render quarto report in HTML and PDF
reports/student_exam_performance.html: results reports/student_exam_performance.qmd
	quarto render reports/student_exam_performance.qmd --to html --execute-dir project

reports/student_exam_performance.pdf: results reports/student_exam_performance.qmd
	quarto render reports/student_exam_performance.qmd --to pdf --execute-dir project


# clean
clean:
	rm -rf results/
	rm -rf reports/student_exam_performance.html \
		reports/student_exam_performance.pdf \
		reports/qmd_example_files
	rm -rf data/
