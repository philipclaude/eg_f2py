# Makefile for pysentropic source directory
# Philip Caplan

# Commands and options
FC 	= gfortran
LD 	= $(FC)
SWP 	= swplist
RM 	= /bin/rm -f
OLEVEL 	= -O3
FOPTS 	= 
LIBOPTS	= -fPIC -static
AR 	= ar
AR_FLAGS= -rvs
FFLAGS 	= $(OLEVEL) $(FOPTS) $(LIBOPTS)
LDFLAGS = $(OLEVEL)

# f2py options (messy output, suppress some of it)
F2PY_OPTS	= --quiet
F2PY_FCOMP	= --fcompiler=gfortran
F2PY_F90OPTS 	= $(FOPTS)
F2PY_FOPTS 	= $(FOPTS)
F2PY_FFLAGS 	= --f90flags=$(F2PY_F90OPTS) --f77flags=$(F2PY_FOPTS)
F2PY_MODULE 	= pysentropic
F2PY_SO 	= $(F2PY_MODULE:=.so)
F2PY_SIG 	= ../pysentropic.pyf

# Libraries to create
FLOLIB_STATIC 	= libpysentropic.a
FLOLIB_SHARED 	= libpysentropic.so

# Libraries to link to (don't actually need here, but just to illustrate)
LIBS 	= -L//sb/software/libraries/GotoBLAS_LAPACK/shared -llapack

# Module files (necessary for f2py wrapping)
MODS	= 	in_var\
		out_var

SUBS 	= 	solvem\

# Automatically adding extensions
SRCF	:= $(SUBS:=.f)
SRCO	:= $(SUBS:=.o)
MODF 	:= $(MODS:=.f)
MODO 	:= $(MODS:=.o)

OBJS 	= $(MODO) $(SRCO)
ALLSRC  = $(MODF) $(SRCF)

# Executable object and name
EXOBJ 	= pysentropic.o
EXEC 	= pysentropic

default: lib

lib: $(OBJS)
	$(AR) $(AR_FLAGS) $(FLOLIB_STATIC) $(OBJS)
	$(FC) -shared $(OBJS) -o $(FLOLIB_SHARED)

wrap: lib
	@echo "Wrapping fortran source using f2py."
	@echo "Suppressing messy output."
	@echo "Please wait ..."
	@f2py $(F2PY_OPTS) $(F2PY_FCOMP) $(F2PY_FFLAGS) -c -m $(F2PY_MODULE) $(F2PY_SIG) $(FLOLIB_STATIC) $(LIBS)
	mv $(F2PY_SO) ../python/$(F2PY_SO)

pyf:
	@echo "Backing up the current signature file ..."	
	f2py $(ALLSRC) -m pysentropic -h ../pysentropic.pyf

clean:
	$(RM) *.o *.a *.so *.mod
	( cd ../python && $(RM) $(EXEC) ) || exit 1;

# Compiling rules
.SUFFIXES:
.SUFFIXES: .o .f .f90

.f.o:
	$(FC) $(FFLAGS)	 -c $< -o $*.o

.f90.o:
	$(FC) $(FFLAGS)	 -c $< -o $*.o
