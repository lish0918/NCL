f1=addfile("../DATA/fnl_20131006_12_00.grib2", "r")
t=f1->TMP_P0_L100_GLL0   ;温度
hgt=f1->HGT_P0_L100_GLL0 ;位势高度
U=f1->UGRD_P0_L100_GLL0 ;风羽图：经向
V=f1->VGRD_P0_L100_GLL0 ;风羽图：纬向
p=f1->lv_ISBL0 ;气压   500hPa对应下标13
rh=f1->RH_P0_L100_GLL0 ;湿度场
lat=f1->lat_0 ;纬度
lon=f1->lon_0 ;经度

u=U(13,:,:)
v=V(13,:,:)

u = 2.5*u        ;   乘2.5是实际风向标
v = 2.5*v

wks=gsn_open_wks("png", "homework-5")

res=True
res@gsnDraw =False 
res@gsnFrame=False

res@gsnLeftString=""
res@gsnRightString=""

mpres=res
mpres@gsnLeftString="50000Pa HGT & T & V & Rh at 10/06/2013 (12:00) UTC"
mpres@gsnLeftStringFontHeightF=0.014
mpres@mpLimitMode="LatLon"  ;以经纬为xy轴
mpres@mpMinLatF=10    ;x轴最小刻度
mpres@mpMaxLatF=50
mpres@mpMinLonF=100
mpres@mpMaxLonF=150

mpres@tmXTOn=False  ;关闭刻度线
mpres@tmYROn=False
mpres@tmXBMinorOn=False  ;关闭小刻度线
mpres@tmYLMinorOn=False
mpres@tmXBMode    = "Explicit" ;数组模式
mpres@tmXBValues=(/100,110,120,130,140,150/)
mpres@tmXBLabels  = (/"100~S~o~N~E","110~S~o~N~E","120~S~o~N~E"\
                     ,"130~S~o~N~E","140~S~o~N~E","150~S~o~N~E"/)
mpres@tmXBLabelFontHeightF=0.01 ;标签栏字体的大小
mpres@tmYLMode    = "Explicit" 
mpres@tmYLValues=(/10,20,30,40,50/)
mpres@tmYLLabels  = (/"10~S~o~N~N","20~S~o~N~N"\
                     ,"30~S~o~N~N","40~S~o~N~N","50~S~o~N~N"/) 

mpres@mpDataBaseVersion="MediumRes"  ;中尺度
mpres@mpOutlineOn="True"   ;显示廓线
mpres@mpOutlineBoundarySets="AllBoundaries"
mpres@mpDataSetName           = "Earth..4" ;earth..4包含中国省份
mpres@mpProvincialLineColor="grey"  ;省份边界线颜色设置
mpres@mpProvincialLineThicknessF=1.5  ;宽度

map=gsn_csm_map(wks, mpres)
gsn_define_colormap(wks, "gui_default")

cnres=res
cnres@cnFillOn=True 
cnres@cnLinesOn=False
cnres@cnLevelSelectionMode ="ExplicitLevels" 
cnres@cnLevels             =(/60,70,80,90/)
cnres@cnFillColors         =(/ "White","Chartreuse","Green",\
                                 "Green3","Green4","ForestGreen"/) 
;cnres@cnFillOpacityF    = 0.3  ;透明度
;cnres@cnFillDrawOrder      = "Predraw"  ;!!!!!!!!叠加在最底层

cnres@lbBoxMinorExtentF=0.15 ;可以控制label bar的比例


contour=gsn_csm_contour(wks, rh(13,:,:), cnres)

vcres=res
vcres@vcRefMagnitudeF=50 ;矢量幅度
vcres@vcRefLengthF=0.035  ; 风向标大小
vcres@vcWindBarbLineThicknessF=2.0 ;线条粗细 默认：1.0
vcres@vcMinDistanceF=0.03 ; 间隔最小距离 
vcres@vcGlyphStyle="WindBarb"
vcres@vcRefAnnoOn=False ;不显示风羽图示例

vector=gsn_csm_vector(wks, u, v, vcres)

c1res=res
c1res@cnLinesOn=True
c1res@cnFillOn=False
c1res@lbLabelBarOn=False

c1res@cnLineThicknessF=4  ;线条粗细
c1res@cnLevelSelectionMode = "ManualLevels"
c1res@cnMinLevelValF       = 5520    ; Set contour levels to
c1res@cnMaxLevelValF       = 6840    ; the same for each plot.
c1res@cnLevelSpacingF      = 40
c1res@cnLineLabelFontHeightF=0.008 ;等值线标签大小
c1res@cnInfoLabelOn=False


c1=gsn_csm_contour(wks, hgt(13,:,:), c1res)

c2res=res
c2res@cnLinesOn=True  ;显示等值线
c2res@cnFillOn=False
c2res@cnLineColor="red"
c2res@gsnContourPosLineDashPattern=2  ;虚线
c2res@cnLineThicknessF=3.2 ;粗细
c2res@lbLabelBarOn=False  ;不显示标签

c2res@cnLevelSelectionMode = "ManualLevels"
c2res@cnMinLevelValF       = 248   ; Set contour levels to
c2res@cnMaxLevelValF       = 280    ; the same for each plot.
c2res@cnLevelSpacingF      = 4
c2res@cnLineLabelFontColor="red" ;等值线标签颜色
c2res@cnLineLabelFontHeightF=0.01
c2res@cnInfoLabelOn=False  ;不显示contour from.. to.. by..

c2=gsn_csm_contour(wks, t(13,:,:), c2res)

overlay(map,contour)
overlay(map,vector)
overlay(map,c2)
overlay(map,c1)

draw(map)
frame(wks)