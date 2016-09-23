<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xsi xlink xml" version="2.0" xpath-default-namespace="http://www.loc.gov/mods/v3" xmlns:adms="http://www.w3.org/ns/adms#"
    xmlns:cc="http://creativecommons.org/ns#" xmlns:crm="http://www.cidoc-crm.org/rdfs/cidoc_crm_v5.0.2_english_label.rdfs#" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dcat="http://www.w3.org/ns/dcat#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:doap="http://usefulinc.com/ns/doap#" xmlns:edm="http://www.europeana.eu/schemas/edm/"
    xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:mets="http://www.loc.gov/METS/" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:odrl="http://www.w3.org/ns/odrl/2/"
    xmlns:ore="http://www.openarchives.org/ore/terms/" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:rdaGr2="http://rdvocab.info/ElementsGr2/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:svcs="http://rdfs.org/sioc/services#" xmlns:wgs84="http://www.w3.org/2003/01/geo/wgs84_pos#" xmlns:xalan="http://xml.apache.org/xalan" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:marcrel="http://id.loc.gov/vocabulary/relators/"
    xmlns:xml="http://www.w3.org/XML/1998/namespace" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output encoding="UTF-8" indent="yes"/>

    <!--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
    <!-- VARIABLES -->
    <!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->

    <!-- FIXED VARIABLES -->

    <!-- Languages mapping ISO_639-2b to ISO_639-1 (when possible) -->
    <!-- Cf. http://loc.gov/standards/iso639-2/php/code_list.php -->
    <!-- Cf. https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes -->
    <xsl:variable name="map_lang">
        <map value="de">ger</map>
        <map value="fr">fre</map>
        <map value="la">lat</map>
        <map value="en">eng</map>
        <map value="it">ita</map>
        <map value="pl">pol</map>
        <map value="nl">dut</map>
        <map value="el">gre</map>
        <map value="ru">rus</map>
        <!-- NO MAP : Greek (Ancient) -->
        <map value="grc">grc</map>
        <!-- NO MAP : Egyptian (Ancient) -->
        <map value="egy">egy</map>
        <map value="sa">san</map>
        <map value="he">heb</map>
        <map value="es">spa</map>
        <map value="hi">hin</map>
        <map value="ar">ara</map>
        <!-- NO MAP : German, Middle High (ca.1050-1500) -->
        <map value="gmh">gmh</map>
        <!-- NO MAP : Copt -->
        <map value="cop">cop</map>
        <!-- NO MAP : Official Aramaic (700-300 BCE); Imperial Aramaic (700-300 BCE) -->
        <map value="arc">arc</map>
        <map value="cs">cze</map>
        <!-- NO MAP : Romany/Tzigane -->
        <map value="rom">rom</map>
        <map value="fr">fra</map>
        <!-- NO MAP : Prakrit languages -->
        <map value="pra">pra</map>
        <map value="da">dan</map>
        <!-- NO MAP : ? -->
        <map value="mehrspr">mehrspr</map>
        <map value="si">sin</map>
        <!-- NO MAP : Classical Syriac -->
        <map value="syc">syc</map>
        <!-- NO MAP : Awadhi -->
        <map value="awa">awa</map>
        <map value="bn">ben</map>
        <!-- NO MAP : Egyptian (Ancient) ?? -->
        <map value="egyp">egyp</map>
        <!-- NO MAP : ? -->
        <map value="gar">gar</map>
        <map value="gec">gec</map>
        <map value="gri">gri</map>
        <!-- ./ -->
        <map value="hu">hun</map>
        <map value="it">ital</map>
        <map value="ne">nep</map>
        <!-- NO MAP : Nepal Bhasa; Newari -->
        <map value="new">new</map>
        <map value="fa">per</map>
        <map value="pi">pli</map>
        <map value="sl">slv</map>
        <!-- NO MAP : ? -->
        <map value="sonst">sonst</map>
        <!-- NO MAP : Syriac -->
        <map value="syr">syr</map>
        <map value="urd">urd</map>
        <!-- NO MAP : Persian, Old (ca.600-400 B.C.) -->
        <map value="peo">peo</map>
        <!-- NO MAP : GR ?? -->
        <map value="gr">gr</map>
    </xsl:variable>

    <!-- Strings changed JBH -->
    <xsl:variable name="baseUrl_manifest">
        <xsl:text>https://data.ucd.ie/api/img/manifests/</xsl:text>
    </xsl:variable>

    <xsl:variable name="baseUrl_service">
        <xsl:text>https://iiif.ucd.ie/loris/</xsl:text>
    </xsl:variable>

    <xsl:variable name="hqPicture">
        <!--<xsl:text>/full/full/0/default.png</xsl:text>-->
        <xsl:text>/full/full/0/default.jpg</xsl:text>
    </xsl:variable>

    <xsl:variable name="thumb">
        <xsl:text>/full/600,/0/default.jpg</xsl:text>
    </xsl:variable>

    <xsl:variable name="format">
        <!--<xsl:text>image/png</xsl:text>-->
        <xsl:text>image/jpeg</xsl:text>
    </xsl:variable>

    <xsl:variable name="provider">
        <xsl:text>University College Dublin</xsl:text>
    </xsl:variable>
    
    <xsl:variable name="provider_name">
        <xsl:text>University College Dublin</xsl:text>
    </xsl:variable>
    
    <xsl:variable name="provider_webview_endpoint">
        <!-- added JBH -->
        <xsl:text>https://digital.ucd.ie/view/</xsl:text>
    </xsl:variable>

    <xsl:variable name="rights">
        <!-- QUESTION: is this licence a Europeana requirement? JBH -->
        <!--<xsl:if test="not(accessCondition/@displayLabel = 'Additional Information'])
            ">
            <xsl:value-of select="accessCondition/@xlink:href"/>
            
        </xsl:if>-->
        <!--    <xsl:if test="not(/mods/accessCondition/@displayLabel)
        and /mods/accessCondition/@xlink:href">
        <xsl:variable name="rights" select="/mods/accessCondition[@type='use and reproduction']/@xlink:href"/>
    </xsl:if>-->
        <xsl:text>http://creativecommons.org/licenses/by-nc-sa/4.0/</xsl:text>
    </xsl:variable>


    <!--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
    <!-- DYNAMIC VARIABLES -->
    <!-- IDs -->
    <!--<xsl:variable name="object_id"
        select="substring-after(/mods/location/url[@usage = 'primary'], 'ivrla_')"/>-->
    <xsl:variable name="object_id" select="substring-after(/mods/identifier[@type = 'uri'], 'fedora/')"/>

    <!--<xsl:variable name="europeana_id" select="concat('ivrla_', $object_id)"/>-->
    <xsl:variable name="europeana_id" select="substring-after(/mods/identifier[@type = 'uri'], 'fedora/')"/>

    <xsl:variable name="resource_id" select="substring-after(/mods/relatedItem[@type = 'constituent'][1]/identifier[@type = 'uri'], 'info:fedora/')"/>




    <!--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
    <!-- MAPPING -->
    <!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->

    <!-- ROOT MATCH -->
    <xsl:template match="/">
        <xsl:apply-templates select="/mods"/>
    </xsl:template>

    <!--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
    <!-- MAIN TEMPLATE -->
    <xsl:template match="/mods">
        <!-- rdf:RDF, id: 0 -->
        <xsl:element name="rdf:RDF">

            <!-- Namespaces declaration -->
            <xsl:namespace name="adms">http://www.w3.org/ns/adms#</xsl:namespace>
            <xsl:namespace name="cc">http://creativecommons.org/ns#</xsl:namespace>
            <xsl:namespace name="crm">http://www.cidoc-crm.org/rdfs/cidoc_crm_v5.0.2_english_label.rdfs#</xsl:namespace>
            <xsl:namespace name="dc">http://purl.org/dc/elements/1.1/</xsl:namespace>
            <xsl:namespace name="dcat">http://www.w3.org/ns/dcat#</xsl:namespace>
            <xsl:namespace name="dcterms">http://purl.org/dc/terms/</xsl:namespace>
            <xsl:namespace name="doap">http://usefulinc.com/ns/doap#</xsl:namespace>
            <xsl:namespace name="edm">http://www.europeana.eu/schemas/edm/</xsl:namespace>
            <xsl:namespace name="foaf">http://xmlns.com/foaf/0.1/</xsl:namespace>
            <!-- new JBH -->
            <xsl:namespace name="marcrel">http://id.loc.gov/vocabulary/relators/</xsl:namespace>
            <xsl:namespace name="odrl">http://www.w3.org/ns/odrl/2/</xsl:namespace>
            <xsl:namespace name="ore">http://www.openarchives.org/ore/terms/</xsl:namespace>
            <xsl:namespace name="owl">http://www.w3.org/2002/07/owl#</xsl:namespace>
            <xsl:namespace name="rdaGr2">http://rdvocab.info/ElementsGr2/</xsl:namespace>
            <xsl:namespace name="rdf">http://www.w3.org/1999/02/22-rdf-syntax-ns#</xsl:namespace>
            <xsl:namespace name="rdfs">http://www.w3.org/2000/01/rdf-schema#</xsl:namespace>
            <xsl:namespace name="skos">http://www.w3.org/2004/02/skos/core#</xsl:namespace>
            <xsl:namespace name="svcs">http://rdfs.org/sioc/services#</xsl:namespace>
            <xsl:namespace name="wgs84">http://www.w3.org/2003/01/geo/wgs84_pos#</xsl:namespace>
            <xsl:namespace name="xalan">http://xml.apache.org/xalan</xsl:namespace>
            <xsl:namespace name="xlink">http://www.w3.org/1999/xlink</xsl:namespace>
            <xsl:namespace name="xml">http://www.w3.org/XML/1998/namespace</xsl:namespace>
            <xsl:namespace name="xsi">http://www.w3.org/2001/XMLSchema-instance</xsl:namespace>

            <!-- PROVIDED CHO -->
            <!-- Check for mandatory elements on edm:ProvidedCHO -->
            <xsl:if test="$object_id">
                <!-- edm:ProvidedCHO, id: 1 -->
                <xsl:element name="edm:ProvidedCHO">
                    <xsl:attribute name="rdf:about">
                        <xsl:value-of select="$europeana_id"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:if>
            <!-- ./PROVIDED CHO -->
            
            
            <!-- new JBH -->
            
            <xsl:for-each select="name[@authority and @valueURI]">
                <xsl:if test="role/roleTerm[@type='code']='arc' or 
                    role/roleTerm[@type='code']='aut' or 
                    role/roleTerm[@type='code']='cmp' or 
                    role/roleTerm[@type='code']='cre' or 
                    role/roleTerm[@type='code']='ctb' or 
                    role/roleTerm[@type='code']='dte' or 
                    role/roleTerm[@type='code']='edt' or 
                    role/roleTerm[@type='code']='fmo' or 
                    role/roleTerm[@type='code']='fnd' or 
                    role/roleTerm[@type='code']='lbt' or 
                    role/roleTerm[@type='code']='pbl' or 
                    role/roleTerm[@type='code']='pdr' or 
                    role/roleTerm[@type='code']='pht' or 
                    role/roleTerm[@type='code']='scl' or 
                    role/roleTerm[@type='code']='spn' or 
                    role/roleTerm[@type='code']='stl' or 
                    role/roleTerm[@type='code']='rth'">
                    <xsl:element name="edm:Agent">
                        <xsl:attribute name="rdf:about">
                            <xsl:value-of select="@valueURI"/>
                        </xsl:attribute>
                        <xsl:element name="skos:prefLabel">
                            <xsl:value-of select="namePart"/>
                        </xsl:element>
                        <xsl:for-each select="role/roleTerm">
                            <xsl:choose>
                                <xsl:when test=".='arc'">
                                    <xsl:element name="marcrel:arc">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Architect</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='aut'">
                                    <xsl:element name="marcrel:aut">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Author</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='cmp'">
                                    <xsl:element name="marcrel:cmp">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Compiler</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='cre'">
                                    <xsl:element name="marcrel:cre">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Creator</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='ctb'">
                                    <xsl:element name="marcrel:ctb">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Contributor</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='dte'">
                                    <xsl:element name="marcrel:dte">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Dedicatee</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='edt'">
                                    <xsl:element name="marcrel:edt">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Editor</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='fmo'">
                                    <xsl:element name="marcrel:fmo">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Former owner</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='fnd'">
                                    <xsl:element name="marcrel:fnd">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Funder</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='lbt'">
                                    <xsl:element name="marcrel:lbt">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Librettist</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='pbl'">
                                    <xsl:element name="marcrel:pbl">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Publisher</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='pdr'">
                                    <xsl:element name="marcrel:pdr">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Project director</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='pht'">
                                    <xsl:element name="marcrel:pht">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Photographer</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='rth'">
                                    <xsl:element name="marcrel:rth">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Research team head</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='scl'">
                                    <xsl:element name="marcrel:scl">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Sculptor</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='stl'">
                                    <xsl:element name="marcrel:stl">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Storyteller</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:when test=".='spn'">
                                    <xsl:element name="marcrel:spn">
                                        <xsl:attribute name="rdf:resource" exclude-result-prefixes="#all">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:attribute>
                                        <xsl:element name="skos:prefLabel">
                                            <xsl:text>Sponsor</xsl:text>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                        
                    </xsl:element>
                </xsl:if>
            </xsl:for-each>
            
            <xsl:for-each select="subject/geographic[@authority='geonames']">
                <xsl:element name="edm:Place">
                    <xsl:attribute name="rdf:about">
                        <xsl:call-template name="normaliseGeonames">
                            <xsl:with-param name="val">
                                <xsl:value-of select="@valueURI"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:attribute>
                    <xsl:element name="skos:prefLabel">
                        <xsl:attribute name="xml:lang">
                            <xsl:text>en</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="subject/geographic[@authority='naf' or @authority='lcsh' or @authority='viaf']">
                <xsl:element name="edm:Place">
                    <xsl:attribute name="rdf:about">
                        <xsl:value-of select="@valueURI"/>
                    </xsl:attribute>
                    <xsl:element name="skos:prefLabel">
                        <xsl:attribute name="xml:lang">
                            <xsl:text>en</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="subject[@xlink:title='GeoNames' and not(@authority)]/geographic">
                <xsl:element name="edm:Place">
                    <xsl:attribute name="rdf:about">
                        <xsl:variable name="xlink_href">
                            <xsl:value-of select="concat('http://www.geonames.org/',substring-before(substring-after(../@xlink:href,'http://www.geonames.org/'),'/'))"/>
                        </xsl:variable>
                        <xsl:call-template name="normaliseGeonames">
                            <xsl:with-param name="val">
                                <xsl:value-of select="$xlink_href"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:attribute>
                    <xsl:element name="skos:prefLabel">
                        <xsl:attribute name="xml:lang">
                            <xsl:text>en</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            
            <xsl:for-each select="subject/cartographics">
                <!-- only process when there is a geonames reference associated with cartographics/@authority -->                
                <xsl:for-each select="coordinates">
                    <xsl:if test="@authority='geonames'">
                        <xsl:if test="contains(.,',')">
                            <xsl:element name="edm:Place">
                                <xsl:attribute name="rdf:about">
                                    <xsl:call-template name="normaliseGeonames">
                                        <xsl:with-param name="val">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:with-param>
                                    </xsl:call-template>
                                </xsl:attribute>
                                <xsl:element name="wgs84:lat">
                                    <xsl:value-of select="substring-before(.,',')"/>
                                </xsl:element>
                                <xsl:element name="wgs84:long">
                                    <xsl:value-of select="substring-after(.,',')"/>
                                </xsl:element>
                                <xsl:choose>
                                    <xsl:when test="../../geographic" exclude-result-prefixes="mods mets">
                                        <xsl:variable name="prefLabel">
                                            <xsl:value-of select="../../geographic[1]"/>
                                        </xsl:variable>
                                        <xsl:if test="string-length($prefLabel) &gt; 0">
                                            <skos:prefLabel>
                                                <xsl:attribute name="xml:lang">
                                                    <xsl:text>en</xsl:text>
                                                </xsl:attribute>
                                                <xsl:value-of select="normalize-space($prefLabel)"/>
                                            </skos:prefLabel>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="preceding::subject/geographic" exclude-result-prefixes="mods mets">
                                        <xsl:variable name="prefLabel">
                                            <xsl:for-each select="preceding::subject/geographic">
                                                <xsl:value-of select="."/>
                                                <xsl:text> -- </xsl:text>
                                            </xsl:for-each>
                                        </xsl:variable>
                                        <xsl:if test="string-length($prefLabel) &gt; 0">
                                            <skos:prefLabel>
                                                <xsl:attribute name="xml:lang">
                                                    <xsl:text>en</xsl:text>
                                                </xsl:attribute>
                                                <xsl:value-of select="normalize-space(substring($prefLabel,1,string-length($prefLabel)-3))"/>
                                            </skos:prefLabel>
                                        </xsl:if>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:element>
                        </xsl:if>
                        <xsl:if test="contains(.,'eastlimit')">
                            <xsl:element name="edm:Place">
                                <xsl:attribute name="rdf:about">
                                    <xsl:call-template name="normaliseGeonames">
                                        <xsl:with-param name="val">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:with-param>
                                    </xsl:call-template>
                                </xsl:attribute>
                                <xsl:element name="dcterms:spatial">
                                    <xsl:attribute name="xsi:type">
                                        <xsl:text>dcterms:Box</xsl:text>
                                    </xsl:attribute>
                                    <xsl:if test="../name/namePart">
                                        <xsl:value-of select="concat('name=',../name/namePart,'; ')"/>
                                    </xsl:if>
                                    <xsl:value-of select="."/>
                                    <xsl:text>; projection=EPSG:4326</xsl:text>
                                </xsl:element>
                                <xsl:if test="preceding::subject/geographic" exclude-result-prefixes="mods mets">
                                    <xsl:variable name="prefLabel">
                                        <xsl:for-each select="preceding::subject/geographic">
                                            <xsl:if test="position() &gt;1 and not(position() = last())">
                                                <xsl:text>, </xsl:text>
                                            </xsl:if>
                                            <xsl:value-of select="."/>
                                        </xsl:for-each>
                                    </xsl:variable>
                                    <xsl:if test="string-length($prefLabel) &gt; 0">
                                        <skos:prefLabel>
                                            <xsl:attribute name="xml:lang">
                                                <xsl:text>en</xsl:text>
                                            </xsl:attribute>
                                            <xsl:value-of select="$prefLabel"/>
                                        </skos:prefLabel>
                                    </xsl:if>
                                </xsl:if>
                            </xsl:element>
                        </xsl:if>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
            
            <!-- WEB RESOURCE -->
            <xsl:if test="$resource_id">

                <!-- edm:WebResource, id: 5 -->
                <xsl:element name="edm:WebResource">
                    <xsl:attribute name="rdf:about">
                        <xsl:value-of select="concat($baseUrl_service, $resource_id, $hqPicture)"/>
                    </xsl:attribute>

                    <!-- dc:format, id: 13 -->
                    <xsl:element name="dc:format">
                        <xsl:value-of select="$format"/>
                    </xsl:element>

                    <!-- dcterms:extent, id: xx -->
                    <!--
                    <xsl:element name="dcterms:extent">
                        <xsl:attribute name="xml:lang">
                            <xsl:value-of select="'en'"/>
                        </xsl:attribute>
                        <xsl:value-of
                            select="/mods/relatedItem[@type = 'constituent'][1]/physicalDescription/extent[1]"
                        />
                    </xsl:element>
                    <xsl:element name="dcterms:extent">
                        <xsl:value-of
                            select="concat(/mods/relatedItem[@type = 'constituent'][1]/physicalDescription/extent[@unit = 'MB'], ' MB')"
                        />
                    </xsl:element>
                    <xsl:element name="dcterms:extent">
                        <xsl:value-of
                            select="concat(/mods/relatedItem[@type = 'constituent'][1]/physicalDescription/extent[@unit = 'pixels'], ' pixels')"
                        />
                    </xsl:element>
 -->

                    <!-- dcterms:extent, id: xx -->
                    <xsl:for-each select="/mods/relatedItem[@type = 'constituent'][1]/physicalDescription/extent">
                        <xsl:choose>
                            <xsl:when test="position() = 1">
                                <xsl:element name="dcterms:extent">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of select="'en'"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="normalize-space(.)"/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:element name="dcterms:extent">
                                    <xsl:choose>
                                        <xsl:when test="@unit">
                                            <xsl:value-of select="concat(., ' ', @unit)"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="."/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>

                    <!-- dcterms:isReferencedBy, id: 77 -->
                    <xsl:element name="dcterms:isReferencedBy">
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="concat($baseUrl_manifest, $object_id)"/>
                        </xsl:attribute>
                    </xsl:element>

                    <!-- svcs:has_service, id: 82 -->
                    <xsl:element name="svcs:has_service">
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="concat($baseUrl_service, $resource_id)"/>
                        </xsl:attribute>
                    </xsl:element>

                </xsl:element>
            </xsl:if>
            <!-- ./WEB RESOURCE -->

            <!-- SKOS CONCEPT -->
            <xsl:if test="subject/@valueURI">
                <xsl:for-each select="subject/@valueURI">
                    <xsl:element name="skos:Concept">
                        <xsl:attribute name="rdf:about">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                        
                        <!--  skos:prefLabel, id: 182  -->
                        <xsl:element name="skos:prefLabel">
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="'en'"/>
                            </xsl:attribute>
                            <xsl:value-of select="../topic"/>
                        </xsl:element>
                        
                    </xsl:element>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="genre[@valueURI]">
                <xsl:for-each select="genre[@valueURI]">
                    <xsl:element name="skos:Concept">
                        <xsl:attribute name="rdf:about">
                            <xsl:value-of select="@valueURI"/>
                        </xsl:attribute>
                        
                        <!--  skos:prefLabel, id: 182  -->
                        <xsl:element name="skos:prefLabel">
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="'en'"/>
                            </xsl:attribute>
                            <xsl:value-of select="."/>
                        </xsl:element>
                        
                    </xsl:element>
                </xsl:for-each>
            </xsl:if>
            <!-- ./SKOS CONCEPT -->

            <!-- Check for mandatory elements -->
            <xsl:if test="$object_id">

                <!-- ORE AGGREGATION -->
                <xsl:element name="ore:Aggregation">

                    <xsl:attribute name="rdf:about">
                        <xsl:value-of select="concat($europeana_id, '_Aggregation')"/>
                    </xsl:attribute>

                    <!-- edm:aggregatedCHO, id: 210 -->
                    <xsl:element name="edm:aggregatedCHO">
                        <xsl:attribute name="rdf:resource">
                            <xsl:attribute name="rdf:about">
                                <xsl:value-of select="$europeana_id"/>
                            </xsl:attribute>
                        </xsl:attribute>
                    </xsl:element>

                    <!--  edm:dataProvider - changes JBH -->
                    <xsl:choose>
                        <xsl:when test="location/physicalLocation[@type='institution']='University College Dublin'">
                            <xsl:element name="edm:dataProvider">
                                <xsl:value-of select="$provider_name"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:when test="location/physicalLocation[@type='institution']">
                            <xsl:element name="edm:dataProvider">
                                <xsl:value-of select="location/physicalLocation[@type='institution']"/>
                            </xsl:element>
                            <xsl:element name="edm:dataProvider">
                                <xsl:value-of select="$provider_name"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:when test="location/physicalLocation[@type='repository']">
                            <xsl:element name="edm:dataProvider">
                                <xsl:value-of select="location/physicalLocation[@type='repository']"/>
                            </xsl:element>
                            <xsl:element name="edm:dataProvider">
                                <xsl:value-of select="$provider_name"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="edm:dataProvider">
                                <xsl:value-of select="$provider_name"/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>

                    <!-- edm:isShownAt, id: 217 -->
                    <!-- Check for mandatory elements on edm:isShownAt -->
                    <xsl:if test="$object_id">
                        <xsl:element name="edm:isShownAt">
                            <xsl:attribute name="rdf:resource">
                                <xsl:choose>
                                    <xsl:when test="location/url">
                                        <xsl:value-of select="location/url"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat($provider_webview_endpoint,$object_id)"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                        </xsl:element>
                        
                    </xsl:if>

                    <!-- Check for mandatory elements on edm:isShownBy -->
                    <!-- edm:isShownBy, id: 219 -->
                    <xsl:if test="$resource_id">
                        <xsl:element name="edm:isShownBy">
                            <xsl:attribute name="rdf:resource">
                                <xsl:value-of select="concat($baseUrl_service, $resource_id, $hqPicture)"/>
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:if>

                    <!-- Check for mandatory elements on edm:object -->
                    <!-- edm:object, id: 221 -->
                    <xsl:if test="$resource_id">
                        <xsl:element name="edm:object">
                            <xsl:attribute name="rdf:resource">
                                <xsl:value-of select="concat($baseUrl_service, $resource_id, $thumb)"/>
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:if>

                    <!-- edm:provider, id: 223 -->
                    <xsl:element name="edm:provider">
                        <xsl:value-of select="$provider"/>
                    </xsl:element>

                    <!-- edm:rights, id: 229 -->
                    <xsl:element name="edm:rights">
                        <xsl:attribute name="rdf:resource" select="$rights"/>
                    </xsl:element>

                </xsl:element>
                <!-- ./ORE AGGREGATION -->

                <!-- PROXY -->
                <xsl:if test="$object_id">
                    <xsl:element name="ore:Proxy">
                        <xsl:attribute name="rdf:about">
                            <xsl:value-of select="$europeana_id"/>
                        </xsl:attribute>

                        <!-- dc:contributor, id: xxx -->
                        <!-- CONSISTENCY ??? -->
                        <!-- this replaced with aprallelism to edm:Agent, below - JBH -->
                        <!--
                        <xsl:for-each select="name[type = 'personal']/namePart">
                            <xsl:element name="dc:contributor">
                                <xsl:value-of select="."/>
                            </xsl:element>
                        </xsl:for-each>
                        -->

                        <!-- dc:date -->
                        <xsl:for-each select="originInfo/dateCreated[keyDate = 'yes']">
                            <xsl:element name="dc:date">
                                <xsl:value-of select="."/>
                            </xsl:element>
                        </xsl:for-each>

                        <!-- dc:description, id: 249 -->
                        <!-- Physical Location -->
                        <xsl:element name="dc:description">
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="'en'"/>
                            </xsl:attribute>

                            <xsl:text>Physical location: </xsl:text>
                            <xsl:for-each select="location/physicalLocation[@type = 'institution' or @type = 'repository' or @type = 'collection' or @type = 'originalRef']">
                                <xsl:value-of select="."/>
                                <xsl:if test="position() &lt; last()">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:element>

                        <!-- Main Description - new JBH added abstract -->
                        <xsl:for-each select="abstract">
                            <xsl:element name="dc:description">
                                <xsl:attribute name="xml:lang">
                                    <xsl:value-of select="'en'"/>
                                </xsl:attribute>
                                <xsl:value-of select="normalize-space(.)"/>
                            </xsl:element>
                        </xsl:for-each>
                        <xsl:for-each select="note">
                            <xsl:element name="dc:description">
                                <xsl:attribute name="xml:lang">
                                    <xsl:value-of select="'en'"/>
                                </xsl:attribute>
                                <!-- the following constants carry over from EAD finding aid element labels - JBH -->
                                <xsl:choose>
                                    <xsl:when test="@displayLabel='Acquisition details' and not(preceding::note/@displayLabel='Acquisition details')">
                                        <xsl:text>Acquisition details: </xsl:text>
                                    </xsl:when>
                                    <xsl:when test="@displayLabel='Biographical/historical information' and not(preceding::note/@displayLabel='Biographical/historical information')">
                                        <xsl:text>Biographical/historical information: </xsl:text>
                                    </xsl:when>
                                    <xsl:when test="@displayLabel='Location of original' and not(preceding::note/@displayLabel='Location of original')">
                                        <xsl:text>Location of original: </xsl:text>
                                    </xsl:when>
                                    <xsl:when test="@displayLabel='Ownership/custodial history' and not(preceding::note/@displayLabel='Ownership/custodial history')">
                                        <xsl:text>Ownership/custodial history: </xsl:text>
                                    </xsl:when>
                                    <xsl:when test="@displayLabel='Scope and content' and not(preceding::note/@displayLabel='Scope and content')">
                                        <xsl:text>Scope and content: </xsl:text>
                                    </xsl:when>
                                </xsl:choose>
                                <xsl:value-of select="normalize-space(.)"/>
                            </xsl:element>
                        </xsl:for-each>
                        
                        <!-- dcterms:tableOfContents - new JBH -->
                        <xsl:for-each select="tableOfContents">
                            <xsl:element name="dcterms:tableOfContents">
                                <xsl:value-of select="normalize-space(.)"/>
                            </xsl:element>
                        </xsl:for-each>

                        <!-- dc:format, id: xxx -->
                        <xsl:for-each select="physicalDescription">

                            <!-- MAIN FORMATs -->
                            <xsl:element name="dc:format">
                                <xsl:attribute name="xml:lang">
                                    <xsl:value-of select="'en'"/>
                                </xsl:attribute>
                                <xsl:value-of select="extent"/>
                            </xsl:element>

                            <!-- change JBH -->
                            <xsl:if test="local-name()='form'">
                                <xsl:element name="dc:format">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of select="'en'"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="form"/>
                                </xsl:element>
                            </xsl:if>

                            <!-- MANUALLY SELECTED FORMAT -->
                            <xsl:element name="dc:format">
                                <!--<xsl:value-of
                                    select="internetMediaType"/>-->
                                <xsl:value-of select="$format"/>
                            </xsl:element>

                        </xsl:for-each>

                        <!-- dc:identifier, id: 255 -->
                        <!-- Local ID - does not always occur JBH-->
                        <xsl:if test="identifier[@type = 'local']">
                            <xsl:element name="dc:identifier">
                                <xsl:value-of select="identifier[@type = 'local']"/>
                            </xsl:element>
                        </xsl:if>

                        <!-- EAD ID -->
                        <!-- EAD ID - does not always occur, confined to objects with associated EAD finding aids JBH-->
                        <xsl:if test="identifier[@type = 'EADseries']">
                            <xsl:element name="dc:identifier">
                                <xsl:value-of select="concat('EADseries:', identifier[@type = 'EADseries'])"/>
                            </xsl:element>
                        </xsl:if>

                        <!-- URI ID -->
                        <xsl:element name="dc:identifier">
                            <xsl:value-of select="$europeana_id"/>
                        </xsl:element>

                        <!-- URI Full ID -->
                        <xsl:element name="dc:identifier">
                            <xsl:value-of select="concat('http://digital.ucd.ie/view/', $object_id)"/>
                        </xsl:element>
                        
                        <!-- DOI ID -->
                        <!-- if assigned - JBH -->
                        <xsl:if test="identifier[@type = 'doi']">
                            <xsl:element name="dc:identifier">
                                <xsl:value-of select="identifier[@type = 'doi']"/>
                            </xsl:element>
                        </xsl:if>
                        
                        <!-- OCLCNUM ID new JBH -->
                        <xsl:if test="identifier[@type = 'oclcnum']">
                            <xsl:element name="dc:identifier">
                                <xsl:value-of select="identifier[@type = 'oclcnum']"/>
                            </xsl:element>
                        </xsl:if>

                        <!-- dc:language, id: 257 -->
                        <!--
                        <xsl:for-each select="language/languageTerm[@type = 'code']/text() | language/scriptTerm[@type = 'code']">
                        -->
                            <!-- ISO LANG ALIGNEMENT  -->
                            <!--<xsl:variable name="idx_lang"
                                select="index-of($map_lang/map, replace(., '^\s*(.+?)\s*$', '$1'))"/>-->
                            <!-- suppressed in favor of alternative below JBH -->
                            <!--
                            <xsl:element name="dc:language"> --><!-- </xsl:for-each> -->
                                <!--<xsl:value-of select="$map_lang/map[$idx_lang]/@value"/>-->
                        <!--
                                <xsl:value-of select="."/>
                            </xsl:element>
                        </xsl:for-each>
                            -->
                        
                        <!-- dc:language, id: 257 -->
                        
                        <!-- the following alternative deals only with language codes - are the plain language names also useful? JBH -->
                        
                        <xsl:for-each select="language/languageTerm[@type='code']">
                            <xsl:variable name="lang_code">
                                <xsl:call-template name="normaliseLanguageCodes">
                                    <xsl:with-param name="code">
                                        <xsl:value-of select="."/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </xsl:variable>
                            <xsl:if test="string-length($lang_code) &gt; 0">
                                <xsl:element name="dc:language">
                                    <xsl:value-of select="$lang_code"/>
                                </xsl:element>
                            </xsl:if>
                        </xsl:for-each>
                        
                        <!-- scriptTerm is probably not what you want - it refers to the style of writing, not language -->
                        <!--
                        <xsl:for-each select="language/scriptTerm[@type = 'code']">
                            <xsl:variable name="lang_code">
                                <xsl:call-template name="normaliseLanguageCodes">
                                    <xsl:with-param name="code">
                                        <xsl:value-of select="."/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </xsl:variable>
                            <xsl:if test="string-length($lang_code) &gt; 0">
                                <xsl:element name="dc:language">
                                    <xsl:value-of select="$lang_code"/>
                                </xsl:element>
                            </xsl:if>
                        </xsl:for-each>
                        -->

                        <!-- dc:publisher, id: xxx -->
                        <xsl:if test="originInfo/publisher">
                            <!-- changed to for-each JBH -->
                            <xsl:for-each select="originInfo/publisher">
                                <xsl:element name="dc:publisher">
                                    <xsl:value-of select="normalize-space(.)"/>
                                </xsl:element>
                            </xsl:for-each>
                        </xsl:if>

                        <!-- dc:rights, id: 265 -->
                        <xsl:for-each select="accessCondition[not(contains(@xlink:href,'creativecommons'))]">
                            <xsl:element name="dc:rights">
                                <xsl:attribute name="xml:lang">
                                    <xsl:value-of select="'en'"/>
                                </xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="@displayLabel='Suggested credit'">
                                        <xsl:text>Suggested credit: </xsl:text>
                                    </xsl:when>
                                </xsl:choose>
                                <xsl:value-of select="normalize-space(.)"/>
                            </xsl:element>
                        </xsl:for-each>
                        <xsl:element name="dc:rights">
                            <xsl:attribute name="rdf:resource">
                                <xsl:text>http://creativecommons.org/licenses/by-nc-sa/4.0/</xsl:text>
                            </xsl:attribute>
                            <xsl:text>Use of this resource is governed by the Creative Commons - Attribution, Non-Commercial, ShareAlike (BY-NC-SA) license.</xsl:text>
                        </xsl:element>

                        <!-- dc:source, id: 268 - changed JBH, does not always occur -->
                        <xsl:if test="recordInfo/recordContentSource">
                            <xsl:element name="dc:source">
                                <xsl:attribute name="xml:lang">
                                    <xsl:value-of select="'en'"/>
                                </xsl:attribute>
                                <xsl:value-of select="recordInfo/recordContentSource"/>
                            </xsl:element>
                        </xsl:if>

                        <!-- dc:subject, id: ??? -->
                        <!-- skos:Concept -->
                        <xsl:if test="subject/@valueURI">
                            <xsl:for-each select="distinct-values(subject/@valueURI)">
                                <xsl:element name="dc:subject">
                                    <xsl:attribute name="rdf:resource">
                                        <xsl:value-of select="."/>
                                    </xsl:attribute>
                                </xsl:element>
                            </xsl:for-each>
                        </xsl:if>

                        <!-- Litterals new JBH -->
                        <xsl:for-each select="subject">
                            <xsl:if test="child::name/namePart">
                                <xsl:element name="dc:subject">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of select="'en'"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="child::name/namePart"/>
                                    <xsl:for-each select="topic">
                                        <xsl:value-of select="concat('--',.)"/>
                                    </xsl:for-each>
                                </xsl:element>
                            </xsl:if>                            
                        </xsl:for-each>
                        <xsl:for-each select="subject/geographic">
                            <xsl:if test="not(preceding-sibling::name) and not(preceding-sibling::topic)">
                                <xsl:element name="dc:subject">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of select="'en'"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="."/>
                                    <xsl:text>--geographic</xsl:text>
                                </xsl:element>
                            </xsl:if>                            
                        </xsl:for-each>
                        
                        <xsl:for-each select="subject">
                            <xsl:variable name="topics">
                                <xsl:if test="child::topic">
                                    <xsl:for-each select="child::node()">
                                        <xsl:choose>
                                            <xsl:when test="local-name()='topic' or local-name()='geographic'">
                                                <xsl:value-of select="normalize-space(.)"/>
                                            </xsl:when>
                                        </xsl:choose>
                                        <xsl:if test="not(position()=last())">
                                            <xsl:if test="local-name()='topic' or local-name()='geographic'">
                                                <xsl:text>--</xsl:text>
                                            </xsl:if>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:if>
                            </xsl:variable>
                            <xsl:if test="string-length($topics) &gt; 0 and not(topic = preceding::topic[1])">
                                <xsl:element name="dc:subject">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of select="'en'"/>
                                    </xsl:attribute>
                                    <xsl:call-template name="normaliseTopics">
                                        <xsl:with-param name="val">
                                            <xsl:value-of select="$topics"/>
                                        </xsl:with-param>
                                    </xsl:call-template>
                                </xsl:element>
                            </xsl:if>
                        </xsl:for-each>
                        

                        <!-- dc:title, id: 274 -->
                        <xsl:element name="dc:title">
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="'en'"/>
                            </xsl:attribute>
                            <xsl:value-of select="normalize-space(titleInfo/title)"/>
                        </xsl:element>
                        
                        <!-- dc:type, id: 276 -->
                        <!-- URIs -->
                        <xsl:for-each select="genre[@valueURI]">
                            <xsl:element name="dc:type">
                                <xsl:attribute name="rdf:resource" select="@valueURI"/>
                            </xsl:element>
                            <xsl:value-of select="."/>
                        </xsl:for-each>

                        <!-- Litterals -->
                        <xsl:for-each select="genre[not(@valueURI)] | typeOfResource">
                            <xsl:element name="dc:type">
                                <xsl:attribute name="xml:lang" select="'en'"/>
                                <xsl:value-of select="."/>
                            </xsl:element>
                        </xsl:for-each>


                        <!-- HIERARCHIES -->
                        <!-- dcterms:isPartOf, id: 508 -->
                        <!-- PARENT ELEMENT -->
                        <xsl:if test="relatedItem[@type = 'host']">
                            <xsl:for-each select="relatedItem[@type = 'host']">
                                <xsl:element name="dcterms:isPartOf">
                                    <xsl:attribute name="rdf:resource" select="substring-after(identifier[@type = 'uri'], 'fedora/')"/>
                                </xsl:element>
                            </xsl:for-each>
                        </xsl:if>
                        <!-- ./HIERARCHIES -->

                        <!-- dcterms:spatial, id: 335 -->
                        <!-- REMOVING THE DUPLICATES -->
                        <!-- commented JBH
                        <xsl:for-each select="distinct-values(subject/geographic)">
                            <xsl:element name="dcterms:spatial">
                                <xsl:value-of select="."/>
                            </xsl:element>
                        </xsl:for-each>
                        -->
                        
                        <!-- new JBH -->
                        <!-- names, parallel top-level statements in edm:Agent -->
                        <xsl:for-each select="name[@authority and @valueURI]">
                            <xsl:if test="role/roleTerm[@type='code']='arc' or 
                                role/roleTerm[@type='code']='aut' or 
                                role/roleTerm[@type='code']='cmp' or 
                                role/roleTerm[@type='code']='cre' or 
                                role/roleTerm[@type='code']='ctb' or 
                                role/roleTerm[@type='code']='dte' or 
                                role/roleTerm[@type='code']='edt' or 
                                role/roleTerm[@type='code']='fmo' or 
                                role/roleTerm[@type='code']='fnd' or 
                                role/roleTerm[@type='code']='lbt' or 
                                role/roleTerm[@type='code']='pbl' or 
                                role/roleTerm[@type='code']='pdr' or 
                                role/roleTerm[@type='code']='pht' or 
                                role/roleTerm[@type='code']='scl' or 
                                role/roleTerm[@type='code']='spn' or 
                                role/roleTerm[@type='code']='stl' or 
                                role/roleTerm[@type='code']='rth'">
                                <xsl:element name="dc:contributor">
                                    <xsl:attribute name="rdf:resource">
                                        <xsl:value-of select="@valueURI"/>
                                    </xsl:attribute>
                                    <xsl:for-each select="role/roleTerm">
                                        <xsl:choose>
                                            <xsl:when test=".='arc'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Architect</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='aut'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Author</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='cmp'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Compiler</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='cre'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Creator</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='ctb'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Contributor</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='dte'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Dedicatee</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='edt'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Editor</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='fmo'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Former owner</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='fnd'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Funder</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='lbt'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Librettist</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='pbl'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Publisher</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='pdr'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Project director</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='pht'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Photographer</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='rth'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Research team head</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='scl'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Sculptor</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='stl'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Storyteller</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test=".='spn'">
                                                <xsl:attribute name="rdfs:label">
                                                    <xsl:text>Sponsor</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                        </xsl:choose>
                                    </xsl:for-each>
                                    <!--
                                    <xsl:value-of select="namePart"/>
                                    -->
                                </xsl:element>
                            </xsl:if>
                        </xsl:for-each>
                        
                        <!-- new JBH -->
                        <xsl:for-each select="subject/geographic[@authority='geonames']">
                            <xsl:element name="dcterms:spatial">
                                <xsl:attribute name="rdf:resource">
                                    <xsl:call-template name="normaliseGeonames">
                                        <xsl:with-param name="val">
                                            <xsl:value-of select="@valueURI"/>
                                        </xsl:with-param>
                                    </xsl:call-template>
                                </xsl:attribute>
                                <!--
                                <xsl:element name="skos:prefLabel">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:text>en</xsl:text>
                                    </xsl:attribute>
                                    <xsl:value-of select="."/>
                                </xsl:element>
                                -->
                            </xsl:element>
                        </xsl:for-each>
                        <xsl:for-each select="subject/geographic[@authority='naf' or @authority='lcsh' or @authority='viaf']">
                            <xsl:if test="not(preceding::subject/geographic/@valueURI = @valueURI)">
                                <xsl:element name="dcterms:spatial">
                                    <xsl:attribute name="rdf:resource">
                                        <xsl:value-of select="@valueURI"/>
                                    </xsl:attribute>
                                </xsl:element>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:for-each select="subject[@xlink:title='GeoNames' and not(@authority)]/geographic">
                            <xsl:element name="dcterms:spatial">
                                <xsl:attribute name="rdf:resource">
                                    <xsl:variable name="xlink_href">
                                        <xsl:value-of select="concat('http://www.geonames.org/',substring-before(substring-after(../@xlink:href,'http://www.geonames.org/'),'/'))"/>
                                    </xsl:variable>
                                    <xsl:call-template name="normaliseGeonames">
                                        <xsl:with-param name="val">
                                            <xsl:value-of select="$xlink_href"/>
                                        </xsl:with-param>
                                    </xsl:call-template>
                                </xsl:attribute>
                                <!--
                                <xsl:element name="skos:prefLabel">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:text>en</xsl:text>
                                    </xsl:attribute>
                                    <xsl:value-of select="."/>
                                </xsl:element>
                                -->
                            </xsl:element>
                        </xsl:for-each>
                        
                        <xsl:for-each select="subject/cartographics">
                            <xsl:for-each select="coordinates">
                                <xsl:if test="contains(.,',')">
                                    <xsl:element name="dcterms:spatial">
                                        <xsl:element name="wgs84:lat">
                                            <xsl:value-of select="substring-before(.,',')"/>
                                        </xsl:element>
                                        <xsl:element name="wgs84:long">
                                            <xsl:value-of select="substring-after(.,',')"/>
                                        </xsl:element>
                                        <xsl:choose>
                                            <xsl:when test="../../geographic" exclude-result-prefixes="mods mets">
                                                <xsl:variable name="prefLabel">
                                                        <xsl:value-of select="../../geographic[1]"/>
                                                </xsl:variable>
                                                <!--
                                                <xsl:if test="string-length($prefLabel) &gt; 0">
                                                    <skos:prefLabel>
                                                        <xsl:attribute name="xml:lang">
                                                            <xsl:text>en</xsl:text>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="normalize-space($prefLabel)"/>
                                                    </skos:prefLabel>
                                                </xsl:if>
                                                -->
                                            </xsl:when>
                                            <xsl:when test="preceding::subject/geographic" exclude-result-prefixes="mods mets">
                                                <xsl:variable name="prefLabel">
                                                    <xsl:for-each select="preceding::subject/geographic">
                                                        <xsl:value-of select="."/>
                                                        <xsl:text> -- </xsl:text>
                                                    </xsl:for-each>
                                                </xsl:variable>
                                                <!--
                                                <xsl:if test="string-length($prefLabel) &gt; 0">
                                                    <skos:prefLabel>
                                                        <xsl:attribute name="xml:lang">
                                                            <xsl:text>en</xsl:text>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="normalize-space(substring($prefLabel,1,string-length($prefLabel)-3))"/>
                                                    </skos:prefLabel>
                                                </xsl:if>
                                                -->
                                            </xsl:when>
                                        </xsl:choose>
                                    </xsl:element>
                                </xsl:if>
                                <xsl:if test="contains(.,'eastlimit')">
                                    <xsl:element name="dcterms:spatial">
                                        <xsl:attribute name="xsi:type">
                                            <xsl:text>dcterms:Box</xsl:text>
                                        </xsl:attribute>
                                        <xsl:if test="../name/namePart">
                                            <xsl:value-of select="concat('name=',../name/namePart,'; ')"/>
                                        </xsl:if>
                                        <xsl:value-of select="."/>
                                        <xsl:text>; projection=EPSG:4326</xsl:text>
                                    </xsl:element>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:for-each>
                        
                        <!-- edm:type, id: 377 -->
                        <xsl:element name="edm:type">
                            <xsl:value-of select="'IMAGE'"/>
                        </xsl:element>

                    </xsl:element>

                </xsl:if>

                <!-- EUROPEANA AGGREGATION -->
                <xsl:element name="edm:EuropeanaAggregation">
                    <xsl:attribute name="rdf:about">
                        <xsl:value-of select="concat($europeana_id, '_EuropeanaAggregation')"/>
                    </xsl:attribute>

                    <xsl:element name="edm:aggregatedCHO">
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="$europeana_id"/>
                        </xsl:attribute>
                    </xsl:element>

                    <!-- edm:country, id: 391 -->
                    <xsl:element name="edm:country">
                        <xsl:value-of select="'Ireland'"/>
                    </xsl:element>

                    <!-- edm:language, id: 400 -->
                    <xsl:element name="edm:language">
                        <xsl:value-of select="'en'"/>
                    </xsl:element>

                    <!-- edm:rights, id: 401 -->
                    <xsl:element name="edm:rights">
                        <xsl:attribute name="rdf:resource" select="$rights"/>
                    </xsl:element>

                </xsl:element>

            </xsl:if>

            <!-- SERVICE -->
            <xsl:if test="$resource_id">
                <xsl:element name="svcs:Service">

                    <xsl:attribute name="rdf:about">
                        <xsl:value-of select="concat($baseUrl_service, $resource_id)"/>
                    </xsl:attribute>

                    <!-- dcterms:conformsTo, id: 503 -->
                    <xsl:element name="dcterms:conformsTo">
                        <xsl:attribute name="rdf:resource">
                            <xsl:text>http://iiif.io/api/image</xsl:text>
                        </xsl:attribute>
                    </xsl:element>
                    
                    <!-- dcterms:isReferencedBy JBH -->
                    
                    <xsl:element name="dcterms:isReferencedBy">
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="concat($baseUrl_manifest,$object_id)"/>
                        </xsl:attribute>
                    </xsl:element>

                    <!-- doap:implements, id: 506 -->
                    <xsl:element name="doap:implements">
                        <xsl:attribute name="rdf:resource">
                            <xsl:text>http://iiif.io/api/image/2/level2.json</xsl:text>
                        </xsl:attribute>
                    </xsl:element>

                </xsl:element>
            </xsl:if>
            

        </xsl:element>
    </xsl:template>
    <!-- ./MAIN TEMPLATE -->
    
    <!-- TOPICS NORMALISE new JBH -->
    <xsl:template name="normaliseTopics">
        <xsl:param name="val"/>
        <xsl:choose>
            <xsl:when test="starts-with($val,'--') and ends-with($val,'--')">
                <xsl:value-of select="substring(substring($val,1,string-length($val)-2),3)"/>
            </xsl:when>
            <xsl:when test="starts-with($val,'--')">
                <xsl:value-of select="substring($val,1,3)"/>
            </xsl:when>
            <xsl:when test="ends-with($val,'--')">
                <xsl:value-of select="substring($val,1,string-length($val)-2)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$val"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- NORMALISE SYNTAX OF GEONAMES REFS - JBH -->
    <xsl:template name="normaliseGeonames">
        <xsl:param name="val"/>
        <xsl:choose>
            <xsl:when test="substring($val,string-length($val)-1) = '/'">
                <xsl:value-of select="$val"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($val,'/')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- ISO 639-3 to ISO 639-1 new JBH -->
    <xsl:template name="normaliseLanguageCodes">
        <xsl:param name="code"/>
        <xsl:choose>
            <xsl:when test="$code='ger'">de</xsl:when>
            <xsl:when test="$code='eng'">en</xsl:when>
            <xsl:when test="$code='spa'">es</xsl:when>
            <xsl:when test="$code='fre'">fr</xsl:when>
            <xsl:when test="$code='gle'">ga</xsl:when>
            <xsl:when test="$code='sth'">ga</xsl:when>
            <xsl:when test="$code='gla'">gd</xsl:when>
            <xsl:when test="$code='lat'">la</xsl:when>
            <xsl:when test="$code='Latn'">la</xsl:when>
            <xsl:when test="$code='ita'">it</xsl:when>
            <xsl:when test="$code='ell'">el</xsl:when><!-- greek -->
            <xsl:when test="$code='gre'">el</xsl:when>
            <xsl:when test="$code='dut'">nl</xsl:when>
            <xsl:when test="$code='nld'">nl</xsl:when>
            <xsl:when test="$code='por'">pt</xsl:when>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
