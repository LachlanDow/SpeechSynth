function tiltFilter = setTiltTilterGen(tiltFilter,tiltDb)
if (isempty(tiltDb))
    tiltFilter.setPassthrough()
else
    tiltfilter.set(3000,dbToLin(-tiltDb))
end
end

