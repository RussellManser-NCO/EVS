#!/usr/bin/bash

component=stats
model=$1

ndays=95
end=$( date --date="${ndays} days ago" '+%Y%m%d' )

#src="dev"
#dest="para"

src_path="/lfs/h2/emc/vpppg/noscrub/emc.vpppg/evs/v2.0/${component}/"
dest_path="/lfs/h1/ops/para/com/evs/v2.0/${component}/"

get_pdy() {
    local day=$1
    if [[ ${day} -gt 16 ]]; then
        pdy=$( date --date="${day} days ago" '+%Y%m%d' )
    else
        pdy="_PDYm${day}_"
    fi
    echo "${pdy}"
}

if [[ "${model}" == "aigefs" ]]; then
    outfile=transfer_evs_d2p_stats_aigefs.list
    rm -f "${outfile}"

    echo "${src_path} ${dest_path}" >> ${outfile}
    echo "+ /aigefs/" >> ${outfile}

    for ((day = ${ndays} ; day >= 2 ; day--)); do
        pdy=$( get_pdy "${day}" )

        echo "+ /aigefs/aigefs.${pdy}/" >> ${outfile}
        echo "+ /aigefs/aigefs.${pdy}/***" >> ${outfile}
        echo "+ /aigefs/gefs.${pdy}/" >> ${outfile}
        echo "+ /aigefs/gefs.${pdy}/***" >> ${outfile}
        echo "+ /aigefs/hgefs.${pdy}/" >> ${outfile}
        echo "+ /aigefs/hgefs.${pdy}/***" >> ${outfile}
        echo "+ /aigefs/atmos.${pdy}/" >> ${outfile}
        echo "+ /aigefs/atmos.${pdy}/aigefs/" >> ${outfile}
        echo "+ /aigefs/atmos.${pdy}/aigefs/***" >> ${outfile}
        echo "+ /aigefs/atmos.${pdy}/apcp24_mean/" >> ${outfile}
        echo "+ /aigefs/atmos.${pdy}/apcp24_mean/" >> ${outfile}
        echo "+ /aigefs/atmos.${pdy}/gefs/" >> ${outfile}
        echo "+ /aigefs/atmos.${pdy}/gefs/***" >> ${outfile}
        echo "+ /aigefs/atmos.${pdy}/hgefs/" >> ${outfile}
        echo "+ /aigefs/atmos.${pdy}/hgefs/***" >> ${outfile}
    done
elif [[ "${model}" == "aigfs" ]]; then
    outfile=transfer_evs_d2p_stats_aigfs.list
    rm -f "${outfile}"

    echo "${src_path} ${dest_path}" >> ${outfile}
    echo "+ /global_det/" >> ${outfile}

    for ((day = ${ndays} ; day >= 2 ; day--)); do
        pdy=$( get_pdy "${day}" )

        echo "+ /global_det/atmos.${pdy}/" >> ${outfile}
        echo "+ /global_det/atmos.${pdy}/aigfs/" >> ${outfile}
        echo "+ /global_det/atmos.${pdy}/aigfs/grid2grid/" >> ${outfile}
        echo "+ /global_det/atmos.${pdy}/aigfs/grid2grid/***" >> ${outfile}
        echo "+ /global_det/atmos.${pdy}/aigfs/grid2obs/" >> ${outfile}
        echo "+ /global_det/atmos.${pdy}/aigfs/grid2obs/***" >> ${outfile}
        echo "+ /global_det/aigfs.${pdy}/" >> ${outfile}
        echo "+ /global_det/aigfs.${pdy}/***" >> ${outfile}
    done
fi

echo "- *" >> ${outfile}
echo "B 100000" >> ${outfile}
