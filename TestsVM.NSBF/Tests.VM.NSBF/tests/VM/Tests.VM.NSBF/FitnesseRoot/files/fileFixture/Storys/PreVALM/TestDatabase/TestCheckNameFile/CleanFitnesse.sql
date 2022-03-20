DECLARE
    v_file_id   NUMBER(15);

BEGIN
    -- select id_file into v_file_id from DAT_VAL_FILE where file_name = '250901_SIS_04127_VALNAT_20220206_1.json';
    select id_file into v_file_id from DAT_VALIDATION where CORRELATION_ID = 'aaaabbbb5afb1ba47d28cfa4b80e08ff';

    IF v_file_id is not null THEN
        DBMS_OUTPUT.PUT_LINE ('Treatment');
        EXECUTE IMMEDIATE
        'delete from TRP_HIST_TRIP_VALIDATION where id_trip_validation in (select id_trip_validation from TRP_TRIP_VALIDATION where id_validation in (select id_validation from dat_validation where id_file = '|| v_file_id ||'))';
        EXECUTE IMMEDIATE
        'delete from TRP_HIST_TRIP where id_trip in (select id_trip from TRP_TRIP where id_trip_validation_start in (select id_trip_validation from TRP_TRIP_VALIDATION
                                                                                                                    where id_validation in (select id_validation from dat_validation where id_file = '|| v_file_id ||')))';
        EXECUTE IMMEDIATE
        'delete from TRP_LINK_TRIP_JOURNEY where id_trip in (select id_trip from TRP_TRIP where id_trip_validation_start in (select id_trip_validation from TRP_TRIP_VALIDATION 
                                                                                                                            where id_validation in (select id_validation from dat_validation where id_file = '|| v_file_id ||')))';

        EXECUTE IMMEDIATE
        'delete from TRP_TRIP where id_trip_validation_start in (select id_trip_validation from TRP_TRIP_VALIDATION where id_validation in (select id_validation from dat_validation
                                                                                                                                        where id_file = '|| v_file_id ||' 
                                                                                                                                        or id_trip_validation_end in (select id_trip_validation from TRP_TRIP_VALIDATION
                                                                                                                                                                    where id_validation in (select id_validation from dat_validation
                                                                                                                                                                                            where id_file = '|| v_file_id ||'))))';
        EXECUTE IMMEDIATE
        'delete from TRP_TRIP_VALIDATION where id_validation in (select id_validation from dat_validation where id_file = '|| v_file_id ||')';
        EXECUTE IMMEDIATE
        'delete from TRP_HIST_JOURNEY where id_journey in (select id_journey from trp_journey where id_journey not in (select id_journey from TRP_LINK_TRIP_JOURNEY))';
        EXECUTE IMMEDIATE
        'delete from TRP_JOURNEY where id_journey not in (select id_journey from TRP_LINK_TRIP_JOURNEY)';

        EXECUTE IMMEDIATE
        'delete from EVT_HISTO_EVENT where id_validation in (select id_validation from dat_validation where id_file = '|| v_file_id ||')';
        EXECUTE IMMEDIATE
        'delete from EVT_CURRENT_EVENT where id_validation in (select id_validation from dat_validation where id_file = '|| v_file_id ||')';
        EXECUTE IMMEDIATE
        'delete from DAT_VAL_KO where id_validation in (select id_validation from dat_validation where id_file = '|| v_file_id ||')';
        EXECUTE IMMEDIATE
        'delete from DAT_RELIABILITY_PERFORMED where id_validation in (select id_validation from dat_validation where id_file = '|| v_file_id ||')';
        EXECUTE IMMEDIATE
        'delete from DPR_VAL_PSEUDONYMIZABLE where id_validation in (select id_validation from dat_validation where id_file = '|| v_file_id ||')';
        EXECUTE IMMEDIATE
        'delete from EVT_BUSINESS_MODULE_EVENT where id_validation in (select id_validation from dat_validation where id_file  = '|| v_file_id ||')';
        EXECUTE IMMEDIATE
        'delete from DAT_VALIDATION where id_file  = '|| v_file_id;
        EXECUTE IMMEDIATE
        'delete from DAT_VAL_FILE where id_file = '|| v_file_id;
    END IF;

    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            DBMS_OUTPUT.PUT_LINE ('No treatment');
END;