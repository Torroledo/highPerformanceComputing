program branchData

	implicit none 
	
	integer, parameter :: n = 100
	integer :: i,j, iter, half, R, max_iter = n*n
	
	real, dimension(n,n) :: inside=0., outside=0., grid=0.
	logical, dimension(n,n) :: interior=.true.
	integer, dimension(n,n) :: x,y
	
	half = (1+n)/2
	R = .8 * half
	
	! Grid initialization 	
	forall(i=1:n,j=1:n) y(i,j) = i 
	forall(i=1:n,j=1:n) x(i,j) = j
		
	where ((x-half)**2 + (y-half)**2 > R**2)
		interior = .false. 
	end where 
	
	where(interior)
		inside = 1.
	elsewhere 
		outside = 1.
	end where
	grid = 0.
	where (y > half) grid = 100.
	
	! Write Inicial Data
	open(unit = 1, file = 'initialData.txt')
	write(1,*) (grid(i,:), i=1,n) 
	close(1)
		
	! Iteration 
	do iter = 1,max_iter 
		grid = 	outside * grid +  &
				inside * .25 * (cshift(grid, dim=1, shift=1) + &
							cshift(grid, dim=1, shift=-1) + &
							cshift(grid, dim=2, shift=1) + &
							cshift(grid, dim=2, shift=-1))
		write(*,*) iter
	end do 
	! Write Final Data
	open(unit = 1, file = 'branchData.txt')
	write(1,*) (grid(i,:), i=1,n)
	close(1)
end program 