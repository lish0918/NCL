f=addfile("../DATA/uv300.nc", "r")
u=f->U(1,:,:)
v=f->V(1,:,:)

  u = 2.5*u
  v = 2.5*v


speed=u
speed=sqrt(u^2+v^2)

wks=gsn_open_wks("x11", "vector")
gsn_define_colormap(wks, "gui_default")

res=True
res@gsnAddCyclic=True
res@gsnRightString=""
res@gsnLeftString=""
res@gsnCenterString=""

res@vcRefMagnitudeF = 20    ;矢量幅度
res@vcMinDistanceF  = 0.02  ; Thins arrows near pole 空间中间隔的最小距离

  res@vcWindBarbLineThicknessF = 2.0  ;default 1.0 线条粗细
  res@vcRefAnnoOn = True           ;风羽图右下角示例
  res@vcRefAnnoString1 = "8" ;示例级数


  res@vcGlyphStyle     = "WindBarb"
  res@vcRefLengthF     = 0.03 ;大小
  vector3  = gsn_csm_vector_map(wks,u,v,res)
