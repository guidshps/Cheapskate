CC = gcc
CFLAGS = -Wall $(shell pkg-config -cflags gtk4)
LIBS = $(shell pkg-config -libs gtk4)

interface_folder = interface
src_folder = $(interface_folder)/src
inc_folder = $(interface_folder)/inc
obj_folder = $(interface_folder)/obj

src_files = $(wildcard $(src_folder)/*.c)
obj_files = $(src_files:$(src_folder)/%.c=$(obj_folder)/%.o)
application_name = cheapskate

.PHONY: all run clean

all: $(application_name)

$(application_name): $(obj_files)
	$(CC) $(CFLAGS) $(obj_files) -o $(application_name) -I$(inc_folder) $(LIBS)

$(obj_files): $(interface_folder)/$(obj_folder)/%.o: $(interface_folder)/$(src_folder)/%.c | $(obj_folder)
	$(CC) $(CFLAGS) -c $^ -o $@ -I$(inc_folder) $(LIBS)

$(obj_folder):
	mkdir $(obj_folder)

run:
	./$(application_name)

clean: 
	rm -f $(obj_files) $(application_name)