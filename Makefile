# Makefile for pyflow f2py example
# This should clarify how syn88 is wrapped
# Philip Caplan

default: wrap

help: 
	@echo "Specify what you would like to make:"
	@echo "make lib     : creates a library from the source"
	@echo "make exec    : create executable"
	@echo "make wrap    : wraps the library for python-interface"
	@echo "make pyf     : backs up old/creates new signature file"
	@echo "make clean   : removes *.o *.mod *.a *.so"

lib:
	@echo "Making library..."
	( cd src && make ) || exit 1;

exec:
	@echo "Making executable..."
	( cd src && $(MAKE) $@ ) || exit 1;

wrap: lib
	@echo "Making python-wrapped version..."
	@( cd src && make ) || exit 1;
	@( cd src && $(MAKE) $@ ) || exit 1;

pyf:
	@echo "Creating new signature file..."
	( cd src && $(MAKE) $@ ) || exit 1;

clean:
	( cd src && $(MAKE) $@ ) || exit 1;
	( cd python && rm *.so ) || exit 1;
