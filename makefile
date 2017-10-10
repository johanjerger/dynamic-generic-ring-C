SOURCE_FOLDER=src
TEST_FOLDER=test
BUILD_FOLDER=build
BUILD_TEST_FOLDER=build_test
TEMPORAL_FOLDER=tmp
INSTALL_FOLDER=/usr/bin

CFLAG=-O3 -Wall -std=gnu11
# DEBUG=-g


.PHONY: all clean clean-test folders install uninstall reinstall lines test test-run
all: clean folders main.o $(TEMPORAL_FOLDER) $(BUILD_FOLDER)
	    gcc $(TEMPORAL_FOLDER)/** -o $(BUILD_FOLDER)/dgr $(CFLAG) $(DEBUG)

main.o:
		#MAIN
		gcc -c $(SOURCE_FOLDER)/main.c -o $(TEMPORAL_FOLDER)/main.o $(CFLAG) $(DEBUG)

		# DGR STRUCTURE
		gcc -c $(SOURCE_FOLDER)/dynamic_generic_ring.c -o $(TEMPORAL_FOLDER)/dynamic_generic_ring.o $(CFLAG) $(DEBUG)
		gcc -c $(SOURCE_FOLDER)/dgr_operations.c -o $(TEMPORAL_FOLDER)/dgr_operations.o $(CFLAG) $(DEBUG)

		#UTILITIES
		gcc -c $(SOURCE_FOLDER)/utilities/utilities.c -o $(TEMPORAL_FOLDER)/utilities.o $(CFLAG) $(DEBUG)

clean:
		-rm -r $(TEMPORAL_FOLDER) $(BUILD_FOLDER)

folders:
		-mkdir $(TEMPORAL_FOLDER) $(BUILD_FOLDER)

install: $(BUILD_FOLDER)/dgr
		cp -p $(BUILD_FOLDER)/dgr $(INSTALL_FOLDER)

uninstall: $(INSTALL_FOLDER)/dgr
		rm $(INSTALL_FOLDER)/dgr

reinstall: uninstall install

lines:
		@ printf "	.c files              "
		@ find $(SOURCE_FOLDER)/ -name '*.c' | xargs wc -l | grep total
		@ printf "	.h files      	       "
		@ find $(SOURCE_FOLDER)/ -name '*.h' | xargs wc -l | grep total
		@ printf "	.c test files          "
		@ find $(TEST_FOLDER)/ -name '*.c' | xargs wc -l | grep total
		@ printf "	.h test files 	        "
		@ find $(TEST_FOLDER)/ -name '*.h' | xargs wc -l | grep total

compile_install: all install

# TEST SECTION

test-run: test
			@ ./$(BUILD_TEST_FOLDER)/dgr_test

test: clean-test folders-test test.o $(TEMPORAL_FOLDER) $(BUILD_TEST_FOLDER)
	    gcc $(TEMPORAL_FOLDER)/** -o $(BUILD_TEST_FOLDER)/dgr_test $(CFLAG) $(DEBUG)

test.o:

		# DGR STRUCTURE
		gcc -c $(SOURCE_FOLDER)/dynamic_generic_ring.c -o $(TEMPORAL_FOLDER)/dynamic_generic_ring.o $(CFLAG) $(DEBUG)
		gcc -c $(SOURCE_FOLDER)/dgr_operations.c -o $(TEMPORAL_FOLDER)/dgr_operations.o $(CFLAG) $(DEBUG)

		#TEST CLASES
	  gcc -c $(TEST_FOLDER)/main_test.c -o $(TEMPORAL_FOLDER)/main_test.o $(CFLAG) $(DEBUG)
		gcc -c $(TEST_FOLDER)/test.c -o $(TEMPORAL_FOLDER)/test.o $(CFLAG) $(DEBUG)

		###RING TEST###

		# METHODS TESTS
		gcc -c $(TEST_FOLDER)/dgr_new_test.c -o $(TEMPORAL_FOLDER)/dgr_new_test.o $(CFLAG) $(DEBUG)
		gcc -c $(TEST_FOLDER)/dgr_add_test.c -o $(TEMPORAL_FOLDER)/dgr_add_test.o $(CFLAG) $(DEBUG)
		gcc -c $(TEST_FOLDER)/dgr_size_test.c -o $(TEMPORAL_FOLDER)/dgr_size_test.o $(CFLAG) $(DEBUG)


		#UTILITIES
		gcc -c $(SOURCE_FOLDER)/utilities/utilities.c -o $(TEMPORAL_FOLDER)/utilities.o $(CFLAG) $(DEBUG)

clean-test:
	  -rm -r $(TEMPORAL_FOLDER) $(BUILD_TEST_FOLDER)

folders-test:
		-mkdir $(TEMPORAL_FOLDER) $(BUILD_TEST_FOLDER)
