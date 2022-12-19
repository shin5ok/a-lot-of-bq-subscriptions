for n in {1..100};
do
    t=$(printf "%05d" $n)
    echo $t
    bq query "select count(id) from dataset1.table$t"
    # bq query "select * from dataset1.table$t order by timestamp desc limit 10"
done
