NAME	= patcher.exe
CC		= clang

SOURCES	= patcher.c
OBJECTS = $(SOURCES:.c=.o)

all: $(NAME)

$(NAME): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(NAME)

%.o: %.c
	$(CC) -c $< -o $@

clean:
	rm $(OBJECTS)

fclean: clean
	rm $(NAME)

re: fclean all