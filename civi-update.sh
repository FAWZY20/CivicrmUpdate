s#!/bin/bash
##
## Développer par Renaud Fradin est Fawzy Elsam
##
################################################
##
##  Update CIVI plugin in Drupal and Wordpress on plesk
##
################################################

shopt -s expand_aliases

######################################################
## security check
######################################################

if [ ! -f ~/.bashrc ]; then
    printf -- '\033[41m  .bashrc must exist. abord. \033[0m\n'
    exit 1
fi

#add functions file
source functions.sh
source ~/.bashrc

echo -e '\e[93m=============================================\033[0m'
echo "Choisissez l'instance que vous souhaitez mettre à jour ?"
echo "Liste des domaines disponibles : "
echo " "
listSite=($(plesk bin site --list))
for site in "${listSite[@]}"; 
        do  
            id=$((id+1))
            echo "$id | $site"
        done
echo " "
read civi_folder
case $civi_folder in
    
    1)
        civi_folder="admin.all-in-appli.fr"
        ;;
    2)
        civi_folder="alainrobertmagicien.com"
        ;;
    3)
        civi_folder="all-in-appli.com"
        ;;
    4)
        civi_folder="all-in-event.com"
        ;;
    5)
        civi_folder="all-in-group.fr"
        ;;
    6)
        civi_folder="all-in-resa.com"
        ;;
    7)
        civi_folder="appli-ce.fr"
        ;;
    8)
        civi_folder="appli-snbcm.com"
        ;;
    9)
        civi_folder="campagnes.gestad.net"
        ;;
    10)
        civi_folder="cloud.guillaumesorel.net"
        ;;
    11)
        civi_folder="clpol.fr"
        ;;
    12)
        civi_folder="cnec.asso.fr"
        ;;
    13)
        civi_folder="cnec.gestad.net"
        ;;
    14)
        civi_folder="coiffure-barometre-cnec.fr"
        ;;
    15)
        civi_folder="csebricorama.fr"
        ;;
    16)
        civi_folder="csepwcsa.fr"
        ;;
    17)
        civi_folder="demo.gestad.net"
        ;;
    18)
        civi_folder="espaces-bormann.com"
        ;;
    19)
        civi_folder="ffmns.fr"
        ;;
    20)
        civi_folder="gestad.fr"
        ;;
    21)
        civi_folder="gestad.net"
        ;;
    22)
        civi_folder="greenlobby.org"
        ;;
    23)
        civi_folder="inec.gestad.net"
        ;;
    24)
        civi_folder="institut-economie-circulaire.fr"
        ;;
    25)
        civi_folder="kanboard.all-in-group.fr"
        ;;
    26)
        civi_folder="media.all-in-group.fr"
        ;;
    27)
        civi_folder="mediateurs.parlemonde.gestad.net"
        ;;
    28)
        civi_folder="new.csepwcsa.fr"
        ;;
    29)
        civi_folder="parlemonde.gestad.net"
        ;;
    30)
        civi_folder="prof.parlemonde.gestad.net"
        ;;
    31)
        civi_folder="sandbox.cnec.gestad.net"
        ;;
    32)
        civi_folder="sandbox.institut-economie-circulaire.fr"
        ;;
    33)
        civi_folder="sandbox.snpmns.gestad.net"
        ;;
    34)
        civi_folder="smc-cse.fr"
        ;;
    35)
        civi_folder="snb-cic.com"
        ;;
    36)
        civi_folder="snpmns.gestad.net"
        ;;
    37)
        civi_folder="snpmns.org"
        ;;
    38)
        civi_folder="stats.all-in-appli.com"
        ;;
    39)
        civi_folder="test.ffmns.gestad.net"
        ;;
    40)
        civi_folder="test.inec.gestad.net"
        ;;
    41)
        civi_folder="test.smc-cse.fr"
        ;;
    42)
        civi_folder="testbash.all-in-group.fr"
        ;;
    43)
        civi_folder="testwp.all-in-group.fr"
        ;;
    44)
        civi_folder="testwpcivi.appli.in"
        ;;
    45)
        civi_folder="upgrade.appli.in"
        ;;
    *)
        echo -e '\e[93m=======================================\033[0m'
        echo -e '\e[93m\033[31m Aucune valeur ne correspond \033[31m'
        echo -e '\e[93m=======================================\033[0m'
        exit 1
        ;;
esac
echo "l'instance choisit est : " $civi_folder
echo -e '\e[93m=============================================\033[0m'

echo -e '\e[93m=============================================\033[0m'
echo "Voulez-vous une version Beta  ?  (O/N)"
echo ""
read civi_type_version
echo -e '\e[93m=============================================\033[0m'

echo -e '\e[93m=============================================\033[0m'
echo "Wordpress (W) ou Drupal (D) ?"
echo " "
read civicrm_version
echo -e '\e[93m=============================================\033[0m'

if [ "$civi_type_version" = "O" ]
then
    if [ "$civicrm_version" = "W" ]
    then
        #echo "Wordpress"
        #functions updateCivicrmWordpress
        updateCivicrmWordpressBeta civi_folder 

    elif [ "$civicrm_version" = "D" ]
    then
        #echo "Drupal"
        #functions updateCivicrmDrupal 
        updateCivicrmDrupalBeta civi_folder
    else
        echo -e '\e[93m=======================================\033[0m'
        echo -e '\e[93m\033[31m Aucun CMS valide sélectionné \033[31m'
        echo -e '\e[93m=======================================\033[0m'
        exit 1
    fi

else
    echo -e '\e[93m=============================================\033[0m'
    echo "Voulez-vous que CiviCRM soit en français (France) ? (O / N ) "
    echo " "
    read civi_reponse
    echo -e '\e[93m=============================================\033[0m'
    
    if [ "$civi_reponse" = "N" ]
    then
        echo -e '\e[93m=============================================\033[0m'
        echo "Choisissez le numéro de la langue dans laquelle doit être CiviCRM ?"
        echo " "
        listLanguage=(
        "af_ZA" "da_DK" "en_CA" "fa_IR" "hi_IN" "ja_JP" "mk_MK" "pt_BR" "sl_SI" "uk_UA"
        "r_EG" "de_CH" "en_GB" "fi_FI" "hu_HU" "km_KH" "nb_NO" "pt_PT" "sq_AL" "vi_VN"
        "g_BG" "de_DE" "es_ES" "fr_CA" "hy_AM" "ko_KR" "nl_BE" "ro_RO" "sr_RS" "zh_CN"
        "a_ES" "el_GR" "es_MX" "id_ID" "lt_LT" "nl_NL" "ru_RU" "sv_SE" "zh_TW"
        "s_CZ" "en_AU" "et_EE" "he_IL" "it_IT" "lv_LV" "pl_PL" "sk_SK" "tr_TR")
        echo ""
        for langue in "${listLanguage[@]}"; 
        do
            i=$((i+1))
            echo  "$i | $langue"
        done
        read civi_language
        case $civi_language in

            1)
                civi_language="af_ZA"
                ;;
            2)
                civi_language="da_DK"
                ;;
            3)
                civi_language="en_CA"
                ;;
            4)
                civi_language="fa_IR"
                ;;

            5)
                civi_language="hi_IN"
                ;;
            6)
                civi_language="ja_JP"
                ;;
            7)
                civi_language="mk_MK"
                ;;
            8)
                civi_language="pt_BR"
                ;;
            9)
                civi_language="sl_SI"
                ;;
            10)
                civi_language="uk_UA"
                ;;
            11)
                civi_language="r_EG"
                ;;
            12)
                civi_language="de_CH"
                ;;
            13)
                civi_language="en_GB"
                ;;
            14)
                civi_language="fi_FI"
                ;;
            15)
                civi_language="hu_HU"
                ;;
            16)
                civi_language="km_KH"
                ;;
            17)
                civi_language="nb_NO"
                ;;
            18)
                civi_language="sq_AL"
                ;;
            19)
                civi_language="vi_VN"
                ;;
            20)
                civi_language="g_BG"
                ;;
            21)
                civi_language="de_DE"
                ;;
            22)
                civi_language="es_ES"
                ;;
            23)
                civi_language="fr_CA"
                ;;
            24)
                civi_language="hy_AM"
                ;;
            25)
                civi_language="ko_KR"
                ;;
            26)
                civi_language="nl_BE"
                ;;
            27)
                civi_language="ro_RO"
                ;;
            28)
                civi_language="sr_RS"
                ;;
            29)
                civi_language="zh_CN"
                ;;
            30)
                civi_language="a_ES"
                ;;
            31)
                civi_language="el_GR"
                ;;
            32)
                civi_language="es_MX"
                ;;
            33)
                civi_language="id_ID"
                ;;
            34)
                civi_language="lt_LT"
                ;;
            35)
                civi_language="nl_NL"
                ;;
            36)
                civi_language="ru_RU"
                ;;
            37)
                civi_language="sv_SE"
                ;;
            38)
                civi_language="zh_TW"
                ;;
            39)
                civi_language="s_CZ"
                ;;
            40)
                civi_language="en_AU"
                ;;
            41)
                civi_language="et_EE"
                ;;
            42)
                civi_language="he_IL"
                ;;
            43)
                civi_language="it_IT"
                ;;
            44)
                civi_language="lv_LV"
                ;;
            45)
                civi_language="pl_PL"
                ;;
            46)
                civi_language="sk_SK"
                ;;
            47)
                civi_language="tr_TR"
                ;;
            *)
                echo -e '\e[93m=======================================\033[0m'
                echo -e '\e[93m\033[31m Aucune valeur ne correspond \033[31m'
                echo -e '\e[93m=======================================\033[0m'
                exit 1
        esac
        echo "La langue choisie et le : " $civi_language
    else
        civi_language="fr_FR"
    fi
    echo -e '\e[93m=============================================\033[0m'

    echo -e '\e[93m=============================================\033[0m'
    echo "Choisissez la version que vous souhaitez installer (X.YY.Z)  ?"
    echo ""
    read civi_version
    echo -e '\e[93m=============================================\033[0m'

    if [[ $civi_version =~ ^[0-9]*.[0-9]*.[0-9]*$ ]]
    then
        if [ "$civicrm_version" = "W" ]
        then
            #echo "Wordpress"
            #functions updateCivicrmWordpress
            updateCivicrmWordpress civi_folder civi_version civi_language

        elif [ "$civicrm_version" = "D" ]
        then
            #echo "Drupal"
            #functions updateCivicrmDrupal 
            updateCivicrmDrupal civi_folder civi_version civi_language 
        else
            echo -e '\e[93m=======================================\033[0m'
            echo -e '\e[93m\033[31m Aucun CMS valide sélectionné \033[31m'
            echo -e '\e[93m=======================================\033[0m'
            exit 1
        fi
    else
        echo -e '\e[93m=======================================\033[0m'
        echo -e '\e[93m\033[31m Ce n est pas un nombre\033[31m'
        echo -e '\e[93m=======================================\033[0m'
        exit 1
    fi
fi