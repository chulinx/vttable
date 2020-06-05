module vttable

fn test_table() {
    tdata := [
       ["name","source","sex","age"],
       ["Meter","80","man",""],
       ["Peter","92","man","21"],
       ["xiaoming","86","woman","18"]
   ]
    t := Table{
                    data:tdata,
                    position:"left",
                    style: "simplicity"
                    }
    t.tables()
}

