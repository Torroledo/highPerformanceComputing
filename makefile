all:
	gfortran benchmark.f90 -o bench
	./bench
data:
	gfortran branchData.f90 -o data
	./data

clean: 
	
