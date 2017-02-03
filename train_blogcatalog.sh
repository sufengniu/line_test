#!/bin/sh

g++ -lm -pthread -Ofast -march=native -Wall -funroll-loops -ffast-math -Wno-unused-result line.cpp -o line -lgsl -lm -lgslcblas
g++ -lm -pthread -Ofast -march=native -Wall -funroll-loops -ffast-math -Wno-unused-result reconstruct.cpp -o reconstruct
g++ -lm -pthread -Ofast -march=native -Wall -funroll-loops -ffast-math -Wno-unused-result normalize.cpp -o normalize
g++ -lm -pthread -Ofast -march=native -Wall -funroll-loops -ffast-math -Wno-unused-result concatenate.cpp -o concatenate

./reconstruct -train blogcatalog.edgelist -output blogcatalog_dense.txt -depth 2 -k-max 5 
./line -train blogcatalog_dense.txt -output blog_1st_wo_norm.txt -binary 0 -size 64 -order 1 -negative 5 -samples 10000 -threads 24 
./line -train blogcatalog_dense.txt -output blog_2nd_wo_norm.txt -binary 0 -size 64 -order 2 -negative 5 -samples 10000 -threads 24
./normalize -input blog_1st_wo_norm.txt -output blog_1st.txt -binary 0
./normalize -input blog_2nd_wo_norm.txt -output blog_2nd.txt -binary 0
./concatenate -input1 blog_1st.txt -input2 blog_2nd.txt -output blog_all.txt -binary 0

