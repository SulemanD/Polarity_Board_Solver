#[cfg(test)]
mod tests {
    
    use super::super::{*};
    use std::fs;
    use std::fs::File;
    use std::io::Write;
    use ntest::timeout;
    use std::iter::FromIterator;
    use std::time::Instant;

    #[test]
    #[timeout(60000)]
    fn test_1_5x6() -> std::io::Result<()>
    {
        let board = [ "LRLRTT", "LRLRBB", "TTTTLR", "BBBBTT", "LRLRBB" ];
        let specs = ( vec![2,3,-1,-1,-1], vec![-1,-1,-1,1,-1], vec![1,-1,-1,2,1,-1], vec![2,-1,-1,2,-1,3] );

        let start = Instant::now();
        let sol = polarity(&board, &specs);
        let stop = start.elapsed().as_millis();

        let a1 = validate_dimensions(&sol, &board);
        assert!(a1, "1: Solution and board dimensions don't match!");
        let a2 = validate_placement(&sol, &board);
        assert!(a2, "1: Found illegal tile placement! Must be one of XX, +-, or -+");
        let a3 = validate_poles(&sol);
        assert!(a3, "1: Found same adjecent polarity! (++ or --)");
        let a4 = validate_constraints(&sol, &specs);
        assert!(a4, "1: Constraints not satisfied!");

        
        let mut file = File::create("1_score.txt")?;
        let str_out = format!("1  -   5x6: PASSED in {} ms\n{:?}", stop, sol);
        file.write_all(str_out.as_bytes())?;

        Ok(())
    }

    #[test]
    #[timeout(60000)]
    fn test_2a_2x2() -> std::io::Result<()>
    {
        let board = [ "TT", "BB" ];
        let specs = (vec![1, 1], vec![1, 1], vec![1, 1], vec![1, 1]);

        let start = Instant::now();
        let sol = polarity(&board, &specs);
        let stop = start.elapsed().as_millis();

        let a1 = validate_dimensions(&sol, &board);
        assert!(a1, "2a: Solution and board dimensions don't match!");
        let a2 = validate_placement(&sol, &board);
        assert!(a2, "2a: Found illegal tile placement! Must be one of XX, +-, or -+");
        let a3 = validate_poles(&sol);
        assert!(a3, "2a: Found same adjecent polarity! (++ or --)");
        let a4 = validate_constraints(&sol, &specs);
        assert!(a4, "2a: Constraints not satisfied!");

        let mut file = File::create("2a_score.txt")?;
        let str_out = format!("2a -   2x2: PASSED in {} ms\n{:?}", stop, sol);
        file.write_all(str_out.as_bytes())?;

        Ok(())
    }

    
    #[test]
    #[timeout(60000)]
    fn test_2b_2x2() -> std::io::Result<()>
    {
        let board = [ "LR", "LR" ];
        let specs = (vec![1, -1], vec![1, -1], vec![1, -1], vec![-1, 1]);

        let start = Instant::now();
        let sol = polarity(&board, &specs);
        let stop = start.elapsed().as_millis();

        let a1 = validate_dimensions(&sol, &board);
        assert!(a1, "2b: Solution and board dimensions don't match!");
        let a2 = validate_placement(&sol, &board);
        assert!(a2, "2b: Found illegal tile placement! Must be one of XX, +-, or -+");
        let a3 = validate_poles(&sol);
        assert!(a3, "2b: Found same adjecent polarity! (++ or --)");
        let a4 = validate_constraints(&sol, &specs);
        assert!(a4, "2b: Constraints not satisfied!");

        let mut file = File::create("2b_score.txt")?;
        let str_out = format!("2b -   2x2: PASSED in {} ms\n{:?}", stop, sol);
        file.write_all(str_out.as_bytes())?;

        Ok(())
    }

    #[test]
    #[timeout(60000)]
    fn test_3a_4x4() -> std::io::Result<()>
    {
        let board = [ "TTLR", "BBLR", "LRTT", "LRBB" ];
        let specs = ( vec![0, 1, 2, -1], vec![0, -1, 1, 2], vec![1, 1, -1, 1], vec![1, 1, 0, 2] );

        let start = Instant::now();
        let sol = polarity(&board, &specs);
        let stop = start.elapsed().as_millis();

        let a1 = validate_dimensions(&sol, &board);
        assert!(a1, "3a: Solution and board dimensions don't match!");
        let a2 = validate_placement(&sol, &board);
        assert!(a2, "3a: Found illegal tile placement! Must be one of XX, +-, or -+");
        let a3 = validate_poles(&sol);
        assert!(a3, "3a: Found same adjecent polarity! (++ or --)");
        let a4 = validate_constraints(&sol, &specs);
        assert!(a4, "3a: Constraints not satisfied!");

        let mut file = File::create("3a_score.txt")?;
        let str_out = format!("3a -   4x4: PASSED in {} ms\n{:?}", stop, sol);
        file.write_all(str_out.as_bytes())?;

        Ok(())
    }

    #[test]
    #[timeout(60000)]
    fn test_3b_4x4() -> std::io::Result<()>
    {
        let board = [ "TLRT", "BLRB", "TLRT", "BLRB" ];
        let specs = ( vec![1, 2, -1, -1], vec![-1, 2, -1, 2], vec![2, -1, 0, 2], vec![2, -1, 2, 2] );

        let start = Instant::now();
        let sol = polarity(&board, &specs);
        let stop = start.elapsed().as_millis();

        let a1 = validate_dimensions(&sol, &board);
        assert!(a1, "3b: Solution and board dimensions don't match!");
        let a2 = validate_placement(&sol, &board);
        assert!(a2, "3b: Found illegal tile placement! Must be one of XX, +-, or -+");
        let a3 = validate_poles(&sol);
        assert!(a3, "3b: Found same adjecent polarity! (++ or --)");
        let a4 = validate_constraints(&sol, &specs);
        assert!(a4, "3b: Constraints not satisfied!");

        let mut file = File::create("3b_score.txt")?;
        let str_out = format!("3b -   4x4: PASSED in {} ms\n{:?}", stop, sol);
        file.write_all(str_out.as_bytes())?;

        Ok(())
    }

    #[test]
    #[timeout(60000)]
    fn test_4a_8x8() -> std::io::Result<()>
    {
        let board = [ "LRTTLRTT", "LRBBLRBB", "TTLRTTLR", "BBLRBBLR", 
                      "LRTTLRTT", "LRBBLRBB", "TTLRTTLR", "BBLRBBLR"];
        let specs = ( vec![-1, -1, 2, 2, 4, -1, 3, 2], vec![-1, 1, -1, 3, 3, -1, -1, 4],
                      vec![0, 4, 3, 3, -1, 3, -1, 1],  vec![2, 2, 3, 3, 2, -1, 1, 3] );

        let start = Instant::now();
        let sol = polarity(&board, &specs);
        let stop = start.elapsed().as_millis();

        let a1 = validate_dimensions(&sol, &board);
        assert!(a1, "4a: Solution and board dimensions don't match!");
        let a2 = validate_placement(&sol, &board);
        assert!(a2, "4a: Found illegal tile placement! Must be one of XX, +-, or -+");
        let a3 = validate_poles(&sol);
        assert!(a3, "4a: Found same adjecent polarity! (++ or --)");
        let a4 = validate_constraints(&sol, &specs);
        assert!(a4, "4a: Constraints not satisfied!");

        let mut file = File::create("4a_score.txt")?;
        let str_out = format!("4a -   8x8: PASSED in {} ms\n{:?}", stop, sol);
        file.write_all(str_out.as_bytes())?;

        Ok(())
    }

    #[test]
    #[timeout(60000)]
    fn test_4b_8x8() -> std::io::Result<()>
    {
        let board = [ "LRLRLRLR", "LRLRTLRT", "TTTTBTTB", "BBBBTBBT", 
                      "LRLRBTTB", "TLRTTBBT", "BLRBBLRB", "LRLRLRLR"];
        let specs = ( vec![-1, 2, 2, 2, 2, 2, 2, 0], vec![1, 1, 1, -1, 3, 3, -1, -1],
                      vec![1, 0, 2, 3, 2, -1, 2, 2], vec![0, 2, 1, 3, 2, 2, 1, -1] );

        let start = Instant::now();
        let sol = polarity(&board, &specs);
        let stop = start.elapsed().as_millis();

        let a1 = validate_dimensions(&sol, &board);
        assert!(a1, "4b: Solution and board dimensions don't match!");
        let a2 = validate_placement(&sol, &board);
        assert!(a2, "4b: Found illegal tile placement! Must be one of XX, +-, or -+");
        let a3 = validate_poles(&sol);
        assert!(a3, "4b: Found same adjecent polarity! (++ or --)");
        let a4 = validate_constraints(&sol, &specs);
        assert!(a4, "4b: Constraints not satisfied!");

        let mut file = File::create("4b_score.txt")?;
        let str_out = format!("4b -   8x8: PASSED in {} ms\n{:?}", stop, sol);
        file.write_all(str_out.as_bytes())?;

        Ok(())
    }

    #[test]
    #[timeout(60000)]
    fn test_5_16x16() -> std::io::Result<()>
    {
        let board = [ "LRLRTTTTTTTTLRLR", "LRLRBBBBBBBBLRLR", "LRTTTTLRTTLRLRTT", "LRBBBBLRBBLRLRBB",  
                    "LRLRLRLRLRLRLRLR", "TLRTTLRTTLRTTLRT", "BLRBBLRBBLRBBLRB", "TTLRLRLRTTLRTTLR", 
                    "BBLRLRLRBBLRBBLR", "TTLRTLRTLRTTTTLR", "BBLRBLRBLRBBBBLR", "LRLRLRLRLRLRLRLR",
                    "LRLRTTLRLRLRTTTT", "LRLRBBLRLRLRBBBB", "TLRTTTTTTLRTTTTT", "BLRBBBBBBLRBBBBB" ];
        let specs = ( vec![-1, -1, -1, 2, 1, 4, 1, 2, 0, 2, -1, 3, 2, -1, -1, 1], 
            vec![0, 0, 3, 2, 1, 2, 3, 2, 0, 1, -1, -1, 2, 1, 1, 1],
            vec![1, 0, 0, 1, -1, 3, 2, 2, 1, -1, 3, 1, 2, -1, 2, -1],
            vec![1, -1, -1, 1, 3, 1, 3, 1, 0, 2, -1, 3, 2, 3, 2, 0] );

        let start = Instant::now();
        let sol = polarity(&board, &specs);
        let stop = start.elapsed().as_millis();

        let a1 = validate_dimensions(&sol, &board);
        assert!(a1, "5: Solution and board dimensions don't match!");
        let a2 = validate_placement(&sol, &board);
        assert!(a2, "5: Found illegal tile placement! Must be one of XX, +-, or -+");
        let a3 = validate_poles(&sol);
        assert!(a3, "5: Found same adjecent polarity! (++ or --)");
        let a4 = validate_constraints(&sol, &specs);
        assert!(a4, "5: Constraints not satisfied!");

        let mut file = File::create("5_score.txt")?;
        let str_out = format!("5 -   16x16: PASSED in {} ms\n{:?}", stop, sol);
        file.write_all(str_out.as_bytes())?;

        Ok(())
    }

    fn validate_dimensions(sol: & Vec<String>, board: & [&str]) -> bool {
        let same_height = sol.len() == board.len();
        let same_width = sol.iter()
            .zip(board.iter())
            .all(|(x, y)| x.len() == y.len());
        same_height && same_width
    }

    fn validate_placement(sol: &Vec<String>, board: &[&str]) -> bool {
        let rows = board.len();
        let cols = board.first().map_or(0, |row| row.len()); // Handle empty board case
        let tiles: Vec<((char, char), (char, char))> = (0..rows)
            .flat_map(|r| (0..cols).map(move |c| get_tiles(sol, board, r, c)))
            .collect();
        tiles.iter().all(|&((s1, s2), _)| {
            (s1, s2) == ('X', 'X') || (s1, s2) == ('+', '-') || (s1, s2) == ('-', '+')
        })
    }

    fn validate_poles(sol: &Vec<String>) -> bool {
        let rows = sol.len();
        let cols = sol.first().map_or(0, |row| row.len()); // Handle empty case
    
        let row_poles: Vec<(char, char)> = (0..rows)
            .flat_map(|r| {
                (0..cols - 1).map(move |c| {
                    let a = sol.get(r).and_then(|row| row.chars().nth(c)).unwrap_or(' ');
                    let b = sol.get(r).and_then(|row| row.chars().nth(c + 1)).unwrap_or(' ');
                    (a, b)
                })
            })
            .collect();
        let row_psd = row_poles.iter().all(|&(a, b)| a == 'X' || a != b);
    
        let col_poles: Vec<(char, char)> = (0..cols)
            .flat_map(|c| {
                (0..rows - 1).map(move |r| {
                    let a = sol.get(r).and_then(|row| row.chars().nth(c)).unwrap_or(' ');
                    let b = sol.get(r + 1).and_then(|row| row.chars().nth(c)).unwrap_or(' ');
                    (a, b)
                })
            })
            .collect();
        let col_psd = col_poles.iter().all(|&(a, b)| a == 'X' || a != b);
    
        col_psd && row_psd
    }

    fn validate_constraints(sol: &Vec<String>, constraints: &(Vec<i32>, Vec<i32>, Vec<i32>, Vec<i32>)) -> bool {
        let (left_cons, right_cons, top_cons, bottom_cons) = constraints;
    
        let sli_rows: Vec<Vec<char>> = sol.iter().map(|row| row.chars().collect()).collect();
        let sli_cols = transpose(sol).iter().map(|col| col.chars().collect()).collect::<Vec<Vec<char>>>();
    
        let plus_row: Vec<i32> = sli_rows.iter().map(|row| row.iter().filter(|&&ch| ch == '+').count() as i32).collect();
        let plus_col: Vec<i32> = sli_cols.iter().map(|col| col.iter().filter(|&&ch| ch == '+').count() as i32).collect();
    
        let minus_row: Vec<i32> = sli_rows.iter().map(|row| row.iter().filter(|&&ch| ch == '-').count() as i32).collect();
        let minus_col: Vec<i32> = sli_cols.iter().map(|col| col.iter().filter(|&&ch| ch == '-').count() as i32).collect();
    
        let mut plus_row_zip = plus_row.iter().zip(left_cons.iter());
        let mut plus_col_zip = plus_col.iter().zip(top_cons.iter());
        let mut minus_row_zip = minus_row.iter().zip(right_cons.iter());
        let mut minus_col_zip = minus_col.iter().zip(bottom_cons.iter());
    
        let plus_row_psd = plus_row_zip.all(|(&s, &c)| c == -1 || s == c);
        let plus_col_psd = plus_col_zip.all(|(&s, &c)| c == -1 || s == c);
        let minus_row_psd = minus_row_zip.all(|(&s, &c)| c == -1 || s == c);
        let minus_col_psd = minus_col_zip.all(|(&s, &c)| c == -1 || s == c);
    
        plus_row_psd && plus_col_psd && minus_row_psd && minus_col_psd
    }

    fn get_tiles(sol: &Vec<String>, board: &[&str], x: usize, y: usize) -> ((char, char), (char, char)) {
        let b1 = board.get(x).and_then(|row| row.chars().nth(y)).unwrap_or(' ');
        let s1 = sol.get(x).and_then(|row| row.chars().nth(y)).unwrap_or(' ');
        
        let (b2, s2) = match b1 {
            'T' => (
                board.get(x + 1).and_then(|row| row.chars().nth(y)).unwrap_or(' '),
                sol.get(x + 1).and_then(|row| row.chars().nth(y)).unwrap_or(' ')
            ),
            'B' => (
                board.get(x.wrapping_sub(1)).and_then(|row| row.chars().nth(y)).unwrap_or(' '),
                sol.get(x.wrapping_sub(1)).and_then(|row| row.chars().nth(y)).unwrap_or(' ')
            ),
            'L' => (
                board.get(x).and_then(|row| row.chars().nth(y + 1)).unwrap_or(' '),
                sol.get(x).and_then(|row| row.chars().nth(y + 1)).unwrap_or(' ')
            ),
            'R' => (
                board.get(x).and_then(|row| row.chars().nth(y.wrapping_sub(1))).unwrap_or(' '),
                sol.get(x).and_then(|row| row.chars().nth(y.wrapping_sub(1))).unwrap_or(' ')
            ),
            _ => panic!("Invalid direction"),
        };
        
        ((s1, s2), (b1, b2))
    }

    fn transpose(matrix: &Vec<String>) -> Vec<String> {
        if matrix.is_empty() {
            return Vec::new();
        }
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut result = vec![String::new(); cols];
        for j in 0..cols {
            for i in 0..rows {
                if let Some(ch) = matrix[i].chars().nth(j) {
                    result[j].push(ch);
                } else {
                    result[j].push(' ');
                }
            }
        }
        result
    }
}

