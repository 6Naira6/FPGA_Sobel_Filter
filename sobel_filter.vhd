library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

entity sobel_filter is
end sobel_filter;

architecture behaviour of sobel_filter is

  function read_pixel(row : integer; col : integer) return integer is
    file input_buf_2 : text;
    variable pixel_line : line;
    variable pixel_word : integer;
  begin
    file_open(input_buf_2, "input.txt", read_mode);
    for i in 1 to row loop
        readline(input_buf_2, pixel_line);
    end loop;
    read(pixel_line, pixel_word);
    for j in 1 to col loop
        read(pixel_line, pixel_word);
    end loop;
    file_close(input_buf_2);
    return pixel_word;
  end function;

begin
  process
    variable col_input : line;
    variable col_output : line;
    variable new_pixel : integer;
    variable sobel_x : integer;
    variable sobel_y : integer;
    variable gradient : integer;
    file input_buf : text;
    file output_buf : text;
  begin
    file_open(input_buf, "input.txt", read_mode);
    file_open(output_buf, "output.txt", write_mode);

    for row in 0 to 255 loop
      readline(input_buf, col_input);
      for col in 0 to 255 loop

        if row = 0 or row = 255 or row = 1 or row = 254 or col = 0 or col = 255 then
          new_pixel := 0;
        else
          sobel_x := (-1 * read_pixel(row-1, col-1)) + (0 * read_pixel(row-1, col)) + (1 * read_pixel(row-1, col+1)) +
                     (-2 * read_pixel(row, col-1)) + (0 * read_pixel(row, col)) + (2 * read_pixel(row, col+1)) +
                     (-1 * read_pixel(row+1, col-1)) + (0 * read_pixel(row+1, col)) + (1 * read_pixel(row+1, col+1));

          sobel_y := (-1 * read_pixel(row-1, col-1)) + (-2 * read_pixel(row-1, col)) + (-1 * read_pixel(row-1, col+1)) +
                     (0 * read_pixel(row, col-1)) + (0 * read_pixel(row, col)) + (0 * read_pixel(row, col+1)) +
                     (1 * read_pixel(row+1, col-1)) + (2 * read_pixel(row+1, col)) + (1 * read_pixel(row+1, col+1));

          gradient := abs(sobel_x) + abs(sobel_y);

          if gradient > 255 then
            new_pixel := 255;
          else
            new_pixel := gradient;
          end if;
        end if;

        write(col_output, new_pixel);
        write(col_output, ' ');
      end loop;

      writeline(output_buf, col_output);
    end loop;

    file_close(input_buf);
    file_close(output_buf);
    wait;
  end process;
end behaviour;
