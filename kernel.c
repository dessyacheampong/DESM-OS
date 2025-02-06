#define VIDEO_MEMORY 0xB8000
#define SCREEN_WIDTH 80
#define SCREEN_HEIGHT 25

// Color codes
#define COLOR_BLACK 0x0
#define COLOR_WHITE 0xF
#define COLOR_RED 0x4
#define COLOR_GREEN 0x2
#define COLOR_BLUE 0x1

// Screen position tracking
int cursor_x = 0;
int cursor_y = 0;

// Function to clear screen
void clear_screen() {
    char *video_memory = (char *)VIDEO_MEMORY;
    for (int i = 0; i < SCREEN_WIDTH * SCREEN_HEIGHT * 2; i += 2) {
        video_memory[i] = ' ';
        video_memory[i + 1] = COLOR_BLACK;
    }
    cursor_x = 0;
    cursor_y = 0;
}

// Function to print character with color
void print_char(char c, char color) {
    char *video_memory = (char *)VIDEO_MEMORY;
    int offset = (cursor_y * SCREEN_WIDTH + cursor_x) * 2;
    
    video_memory[offset] = c;
    video_memory[offset + 1] = color;
    
    cursor_x++;
    if (cursor_x >= SCREEN_WIDTH) {
        cursor_x = 0;
        cursor_y++;
    }
}

// Function to print string
void print_string(const char *str, char color) {
    while (*str) {
        print_char(*str++, color);
    }
}

// Kernel main function
void kernel_main() {
    // Clear screen
    clear_screen();
    
    // Print welcome messages in different colors
    print_string("Welcome to My Custom Kernel!", COLOR_GREEN);
    
    // Simulate some system initialization steps
    print_string("\nInitializing system components...", COLOR_BLUE);
    
    // Simulate error or warning
    print_string("\nSystem ready with potential warnings!", COLOR_RED);
}
