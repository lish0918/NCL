setfileoption("bin", "ReadByteOrder", "LittleEndian")

M=145    ;x/lon  0~360
N=73     ;y/lat  
data=fbindirread("../DATA/SST_ENSO.dat", 0, (/N,M/), "float")
;读取固定长度的二进制数据

lon  = lonGlobeF(M, "lon", "longitude", "degrees_east")
lat  = latGlobeF(N, "lat", "latitude", "degrees_north")
;                 大小   name    long_name     单位 
data!0="lat"
data!1="lon"
data&lat=lat
data&lon=lon
;----------------------------------
wks=gsn_open_wks("png", "homework-3")
gsn_define_colormap(wks,"amwg_blueyellowred")  
drawNDCGrid(wks)  ;用于画网格线

res=True

;res@vpXF  = 0.1     ;定位 左上角
;res@vpYF  = 0.7
;res@vpWidthF  = 0.9
;res@vpHeightF = 0.2

res@mpLimitMode ="LatLon"
res@mpMinLatF=-30
res@mpMaxLatF=30
res@mpMaxLonF = 290 ;W70
res@mpMinLonF = 30  ;E30 
res@tmYROn=False

res@tmXBLabelFontHeightF  = 0.01  ;标签栏高度
res@tmYLLabelFontHeightF  = 0.01

res@mpCenterLonF=160   ; 中心定位
res@gsnAddCyclic=False  ; 本初子午线间隙

res@cnFillDrawOrder = "PreDraw"
res@cnFillOn  = True
res@cnLinesOn = False

res@cnLevelSelectionMode="ExplicitLevels"
res@cnLevels=(/-1.4,-1.2,-1.0,-0.8,-0.6,-0.4,\
              -0.2,0,0.2,0.4,0.6,0.8,1.0,1.2,1.4/) ;label bar 设置
res@cnFillColors=(/2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17/)
res@lbLabelStride = 2  ;label bar string 间隔    default：1
res@pmLabelBarOrthogonalPosF=0.2  ;label bar与图示的距离  default: 0.02

plot2=gsn_csm_contour_map(wks, data, res)