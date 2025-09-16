import pygame
import sys

# Initialize Pygame
pygame.init()

# Set up the display
screen_width, screen_height = 800, 600
screen = pygame.display.set_mode((screen_width, screen_height))
pygame.display.set_caption("Juan's Animation")

# Load GIFs (assuming GIFs are converted to images)
juan_up = [pygame.image.load(f'juan_up_{i}.png') for i in range(4)]
juan_down = [pygame.image.load(f'juan_down_{i}.png') for i in range(4)]
juan_left = [pygame.image.load(f'juan_left_{i}.png') for i in range(4)]
juan_right = [pygame.image.load(f'juan_right_{i}.png') for i in range(4)]

# Character attributes
x, y = screen_width // 2, screen_height // 2
direction = 'down'
frame_index = 0
clock = pygame.time.Clock()

# Main loop
while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()

    keys = pygame.key.get_pressed()
    
    if keys[pygame.K_UP]:
        y -= 5
        direction = 'up'
    elif keys[pygame.K_DOWN]:
        y += 5
        direction = 'down'
    elif keys[pygame.K_LEFT]:
        x -= 5
        direction = 'left'
    elif keys[pygame.K_RIGHT]:
        x += 5
        direction = 'right'
    else:
        frame_index = 0  # Show first frame when not moving

    # Update frame index for animation
    if direction in ['up', 'down', 'left', 'right']:
        frame_index = (frame_index + 1) % 4

    # Clear the screen
    screen.fill((255, 255, 255))

    # Draw the current frame based on direction
    if direction == 'up':
        screen.blit(juan_up[frame_index], (x, y))
    elif direction == 'down':
        screen.blit(juan_down[frame_index], (x, y))
    elif direction == 'left':
        screen.blit(juan_left[frame_index], (x, y))
    elif direction == 'right':
        screen.blit(juan_right[frame_index], (x, y))

    pygame.display.flip()
    clock.tick(10)  # Control the frame rate
