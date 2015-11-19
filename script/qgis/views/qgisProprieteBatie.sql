-- Create view proprietebatie based on Qgis Models

CREATE OR REPLACE VIEW #schema_cadastrapp.proprietebatie AS 
	SELECT proprietebatie.id_local,
		proprietebatie.comptecommunal,
		proprietebatie.dnupro,
		proprietebatie.cgocommune,
		proprietebatie.ccopre,
		proprietebatie.ccosec,
		proprietebatie.dnupla,
		proprietebatie.jdatat,
		proprietebatie.voie,
		proprietebatie.dnvoiri,
		proprietebatie.dindic,
		proprietebatie.natvoi,
		proprietebatie.ccovoi,
		proprietebatie.dvoilib,
		proprietebatie.ccoriv,
		proprietebatie.dnubat,
		proprietebatie.descr,
		proprietebatie.dniv,
		proprietebatie.dpor,
		proprietebatie.invar,
		proprietebatie.ccoaff,
		proprietebatie.ccoeva,
		proprietebatie.ccolloc,
		proprietebatie.gnextl,
		proprietebatie.jandeb,
		proprietebatie.janimp,
		proprietebatie.fcexb,
		proprietebatie.mvltieomx,
		proprietebatie.bateom,
		proprietebatie.jannat,
		proprietebatie.dvltrt,
		proprietebatie.dvldif2a,
		proprietebatie.vlbaia,
		proprietebatie.vlbaia_com,
		proprietebatie.vlbaia_dep,
		proprietebatie.vlbaia_reg
	FROM dblink('host=#DBHost_qgis dbname=#DBName_qgis user=#DBUser_qgis password=#DBpasswd_qgis'::text,  
		'select 
			l.local00 as id_local,
			c.comptecommunal,
			c.dnupro,
			c.ccodep || c.ccodir ||	c.ccocom as cgocommune,
			l.ccopre,
			l.ccosec,
			ltrim(l.dnupla, ''0'') as dnupla,
			COALESCE(to_char(l.jdatat, ''DD/MM/YYYY''), '''') as jdatat,
			v.voie,
			l.dnvoiri,
			l00.dindic,
			v.natvoi,
			l.ccovoi,
			v.libvoi as dvoilib,
			l00.ccoriv,
			l00.dnubat,
			l00.descr,
			l00.dniv,
			l00.dpor,
			l00.invar,
			pev.ccoaff,
			l.ccoeva,
			pevx.ccolloc,
			pevx.gnextl,
			pevx.jandeb,
			pevx.janimp,
			pevx.fcexb,
			pevtax.mvltieomx,
			pevtax.bateom,
			l.jannat,
			l.dvltrt,
			pevx.dvldif2a,
			pevtax.tse_vlbaia as vlbaia,
			pevtax.co_vlbaia as vlbaia_com,
			pevtax.de_vlbaia as vlbaia_dep,
			pevtax.re_vlbaia as vlbaia_reg
		from #DBSchema_qgis.comptecommunal c
			left join #DBSchema_qgis.local10 as l on c.comptecommunal=l.comptecommunal
			left join #DBSchema_qgis.local00 as l00 on l00.local00=l.local00
			left join #DBSchema_qgis.voie as v on  l.voie=v.voie
			left join #DBSchema_qgis.pev  on pev.local10=l.local10
			left join #DBSchema_qgis.pevexoneration as pevx on pevx.pev=pev.pev
			left join #DBSchema_qgis.pevtaxation as pevtax on pevtax.pev=pev.pev
		order by c.ccodep,c.ccodir,c.ccocom,dnupla,v.voie,v.libvoi,l00.dnubat,l00.descr,l00.dniv,l00.dpor'::text) 
	proprietebatie(
		id_local character varying(14), 
		comptecommunal character varying(15), 
		dnupro character varying(6), 
		cgocommune character varying(6), 
		ccopre character varying(3), 
		ccosec character varying(2), 
		dnupla character varying(4), 
		jdatat character varying(10), 
		voie character varying(19), 
		dnvoiri character varying(4), 
		dindic character varying(1), 
		natvoi character varying(4), 
		ccovoi character varying(5), 
		dvoilib character varying(26),
		ccoriv character varying(4), 
		dnubat character varying(2), 
		descr character varying(2), 
		dniv character varying(2), 
		dpor character varying(5), 
		invar character varying(10),
  		ccoaff character varying(1), 
  		ccoeva character varying(1), 
  		ccolloc character varying(2), 
		gnextl character varying(2), 
		jandeb character varying(4), 
		janimp character varying(4), 
		fcexb character varying(9),
		mvltieomx integer, 
		bateom integer,
		jannat character varying(4),
		dvltrt integer,
		dvldif2a integer,
		vlbaia integer,
		vlbaia_com integer,
		vlbaia_dep integer,
		vlbaia_reg integer);

ALTER TABLE #schema_cadastrapp.proprietebatie OWNER TO #user_cadastrapp;
