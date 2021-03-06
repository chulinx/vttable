// table.v
module vttable

import strings

pub struct Table {
  pub mut:
    data [][]string
    position string
    style string
}

pub fn(t Table) colmax() []int {
    cols := t.data[0].len
    mut maxs := []int{}
    // 获取列字符串的最大长度值
    for j:=0;j<cols;j++ {
        mut b := []string{}
        for i in t.data {
            b << i[j]
        }
        mut max := 0
        for y in b {
            if y.len > max {
                max = y.len
            }
        }
        maxs << max
    }
    return maxs
}

pub fn version() {
    println("vttable: v0.01")
}


pub fn(t Table) tables() {
    mut lines := []string{}
    // 渲染表格
    for ri,row in t.data {
        // println(t.data)
        mut srowcontent := []string{}
        // 清空lines
        lines = []
        if t.position == "center" {
            for i, c in row {
                mut cfilling := ""
                mut wrow := 0
                mut nc   := ""
                mut filling := ""
                maxcol := t.colmax()[i]
                if maxcol % 2 == 1 {
                    wrow = maxcol + 1
                } else {
                    wrow = maxcol + 2
                }
                
                mut line := strings.repeat(`-`,wrow)
                if c.len % 2 == 1 {
                    nc = c + " "
                    filling = strings.repeat(` `,wrow-1-c.len)
                } else {
                    nc = c
                    filling = strings.repeat(` `,wrow-c.len)
                }

                cfilling = strings.repeat(` `,(filling.len +2 )/2)
                line = strings.repeat(`-`,line.len +2)
                if srowcontent.len >0 {
                    srowcontent << "$cfilling$nc$cfilling|"
                    lines << "$line+"
                }else {
                    srowcontent << "|$cfilling$nc$cfilling|"
                    lines << "+$line+"
                }
            }
            if ri > 1 && t.style == "simplicity"{
                println(arraytostr(srowcontent))
            } else {
                for p in [lines,srowcontent] {
                    println(arraytostr(p))
                }
            }

        } else if t.position == "right" {
            for i, c in row {
                wrow := t.colmax()[i]+1
                line := strings.repeat(`-`,wrow)
                filling := strings.repeat(` `,wrow-c.len)
                if srowcontent.len >0 {
                    srowcontent << "$filling$c|"
                    lines << "$line+"
                }else {
                    srowcontent << "|$filling$c|"
                    lines << "+$line+"
                }
            }
            if ri > 1 && t.style == "simplicity"{
                println(arraytostr(srowcontent))
            } else {
                for p in [lines,srowcontent] {
                    println(arraytostr(p))
                }
            }
        } else {
            for i, c in row {
                wrow := t.colmax()[i]+1
                line := strings.repeat(`-`,wrow)
                filling := strings.repeat(` `,wrow-c.len)
                if srowcontent.len >0 {
                    srowcontent << "$c$filling|"
                    lines << "$line+"
                }else {
                    srowcontent << "|$c$filling|"
                    lines << "+$line+"
                }
            }
            if ri > 1 && t.style == "simplicity"{
                println(arraytostr(srowcontent))
            } else {
                for p in [lines,srowcontent] {
                    println(arraytostr(p))
                }
            }
        }
    }
    // 最后打印一行
    println(arraytostr(lines))
}

// array 转 string
fn arraytostr(a []string) string {
    mut s := ""
    for i in a {
        s += i
    }
    return s
}