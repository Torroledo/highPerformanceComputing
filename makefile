all:
	gfortran benchmark.f90 -o bench
	./bench
clean: 
	
