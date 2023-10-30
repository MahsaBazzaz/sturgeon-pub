set -e
set -x

export STG_MUTE_TIME=1

rm -rf work
mkdir -p work

# tiny levels
python3 input2tile.py --outfile work/tiny.tile --textfile levels/kenney/tiny-*.lvl --imagefile levels/kenney/tiny-*.png
python3 levels2explore.py --outfile work/tiny.explore --tilefile work/tiny.tile
python3 explore2summary.py --explorefile work/tiny.explore
python3 explorer.py --test --explorefile work/tiny.explore

# cave levels
python3 input2tile.py --outfile work/cave-base.tile --textfile levels/kenney/cave.lvl --imagefile levels/kenney/cave.png --no-levels
python3 input2tile.py --outfile work/cave.tile --textfile levels/kenney/cave.lvl --imagefile levels/kenney/cave.png --basefile work/cave-base.tile
python3 tile2scheme.py --outfile work/cave.scheme --tilefile work/cave.tile --countdivs 1 1 --pattern nbr-plus
python3 scheme2output.py --outfile work/cave-00 --randomize 0 --result-only --schemefile work/cave.scheme --size 10 10 --reach-move maze --reach-goal br-tl 5
python3 scheme2output.py --outfile work/cave-01 --randomize 1 --result-only --schemefile work/cave.scheme --size 11 11 --reach-move maze --reach-goal br-tl 5
python3 scheme2output.py --outfile work/cave-02 --randomize 2 --result-only --schemefile work/cave.scheme --size 12 12 --reach-move maze --reach-goal br-tl 5
python3 scheme2output.py --outfile work/cave-03 --randomize 3 --result-only --schemefile work/cave.scheme --size 13 13 --reach-move maze --reach-goal br-tl 5
python3 scheme2output.py --outfile work/cave-04 --randomize 4 --result-only --schemefile work/cave.scheme --size 14 14 --reach-move maze --reach-goal br-tl 5
python3 levels2explore.py --outfile work/cave.explore --tilefile work/cave-base.tile --resultfile work/cave-*.result
python3 explore2summary.py --explorefile work/cave.explore
python3 explorer.py --test --explorefile work/cave.explore
