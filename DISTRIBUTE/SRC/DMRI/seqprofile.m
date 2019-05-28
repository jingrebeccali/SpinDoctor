function ft = seqprofile(time);
  
  global BDELTA SDELTA SEQ OGSEPER
  global PGSE OGSEsin OGSEcos dPGSE
  
  ft = zeros(size(time));

  
  if (SEQ == PGSE)  

    ft(time >= 0 & time <= SDELTA) = 1;
    ft(time >= BDELTA & time <= BDELTA+SDELTA) = -1;

  elseif (SEQ == OGSEsin)
      
    [ii] = find(time >= 0 & time <= SDELTA);
    ft(ii) = sin(time(ii)/OGSEPER*2*pi);
    [ii] = find(time >= BDELTA & time <= BDELTA+SDELTA);
    ft(ii) = -sin((time(ii)-BDELTA)/OGSEPER*2*pi);  
    
    
  elseif (SEQ == OGSEcos)
    [ii] = find(time >= 0 & time <= SDELTA);
    ft(ii) = cos(time(ii)/OGSEPER*2*pi);
    [ii] = find(time >= BDELTA & time <= BDELTA+SDELTA);
    ft(ii) = -cos((time(ii)-BDELTA)/OGSEPER*2*pi); 
    
    
  elseif (SEQ == dPGSE) % double PGSE  
    ft(time >= 0 & time <= SDELTA) = 1;
    ft(time > BDELTA & time <= BDELTA+SDELTA) = -1;
    displacement = BDELTA+SDELTA;
    ft(time > 0 + displacement & time <= SDELTA + displacement) = 1;
    ft(time > BDELTA + displacement & time <= BDELTA+SDELTA + displacement) = -1;
  else
    global sym_s sym_ft sym_SDELTA sym_BDELTA
    syms sym_s sym_SDELTA sym_BDELTA
    ft=double(subs(sym_ft, {sym_s, sym_SDELTA, sym_BDELTA}, {time, SDELTA, BDELTA}));
    disp('error in seqprofile');
    stop    
  end

  %disp([time,ft]);
