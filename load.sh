killall tpcc_load
export LD_LIBRARY_PATH=/usr/local/mysql/lib/mysql/
DBNAME=tpcc
WH=2
HOST=192.168.0.12
USER=mock
PWD=mock
STEP=10
RES=result

mkdir -p $RES
./tpcc_load -h $HOST -d $DBNAME -u $USER -p $PWD -w $WH -l 1 -m 1 -n $WH >> $RES/1.out &

x=1

while [ $x -le $WH ]
do
 echo $x $(( $x + $STEP - 1 ))
./tpcc_load -h $HOST -d $DBNAME -u $USER -p $PWD -w $WH -l 2 -m $x -n $(( $x + $STEP - 1 ))  >> $RES/2_$x.out &
./tpcc_load -h $HOST -d $DBNAME -u $USER -p $PWD -w $WH -l 3 -m $x -n $(( $x + $STEP - 1 ))  >> $RES/3_$x.out &
./tpcc_load -h $HOST -d $DBNAME -u $USER -p $PWD -w $WH -l 4 -m $x -n $(( $x + $STEP - 1 ))  >> $RES/4_$x.out &
 x=$(( $x + $STEP ))
done
