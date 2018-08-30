DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `old_password`(p VARCHAR(255)) RETURNS varchar(16) CHARSET utf8
BEGIN
    declare nr,nr2,ad,tmp,i INT UNSIGNED;
    declare c char;
    set nr=1345345333;
    set nr2=0x12345671;
    set ad=7;
    set i =1;
    l: while i<length(p)+1 do
        set tmp = ord(substr(p,i,1));
        set i=i+1;
        if ( tmp=32 or tmp=9 ) then iterate l; end if;
        set nr = nr ^ ((((nr & 63) + ad) * tmp) + ((nr << 8) & 0xFFFFFFFF));
        set nr2 = (nr2 + (nr2 << 8) ^ nr) & 0xFFFFFFFF;
        set ad = ad + tmp;
    end while;
    set nr=nr & 0x7fffffff;
    set nr2=nr2 & 0x7fffffff;
    
RETURN lower(concat(lpad(hex(nr),8,'0'),lpad(hex(nr2),8,'0')));
END ;;
DELIMITER ;
