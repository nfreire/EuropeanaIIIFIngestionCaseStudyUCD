<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xsi xlink xml" version="2.0"
    xpath-default-namespace="http://www.loc.gov/mods/v3" xmlns:adms="http://www.w3.org/ns/adms#"
    xmlns:cc="http://creativecommons.org/ns#"
    xmlns:crm="http://www.cidoc-crm.org/rdfs/cidoc_crm_v5.0.2_english_label.rdfs#"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcat="http://www.w3.org/ns/dcat#"
    xmlns:dcterms="http://purl.org/dc/terms/" xmlns:doap="http://usefulinc.com/ns/doap#"
    xmlns:edm="http://www.europeana.eu/schemas/edm/" xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:mets="http://www.loc.gov/METS/" xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns:odrl="http://www.w3.org/ns/odrl/2/" xmlns:ore="http://www.openarchives.org/ore/terms/"
    xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:rdaGr2="http://rdvocab.info/ElementsGr2/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:svcs="http://rdfs.org/sioc/services#"
    xmlns:wgs84="http://www.w3.org/2003/01/geo/wgs84_pos#" xmlns:xalan="http://xml.apache.org/xalan"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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

    <!-- Strings -->
    <xsl:variable name="baseUrl_manifest">
        <xsl:text>https://data.ucd.ie/api/img/manifests/ivrla:</xsl:text>
    </xsl:variable>

    <xsl:variable name="baseUrl_service">
        <xsl:text>https://iiif.ucd.ie/loris/ivrla:</xsl:text>
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

    <xsl:variable name="rights">
        <!--<xsl:if test="not(accessCondition/@displayLabel = 'Additional Information'])
            ">
            <xsl:value-of select="accessCondition/@xlink:href"/>
            
        </xsl:if>-->
        <!--    <xsl:if test="not(/mods/accessCondition/@displayLabel)
        and /mods/accessCondition/@xlink:href">
        <xsl:variable name="rights" select="/mods/accessCondition[@type='use and reproduction']/@xlink:href"/>
    </xsl:if>-->
        <xsl:text>http://creativecommons.org/licenses/by-nc-sa/3.0/ie/</xsl:text>
    </xsl:variable>



    <!--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
    <!-- DYNAMIC VARIABLES -->
    <!-- IDs -->
    <!--<xsl:variable name="object_id"
        select="substring-after(/mods/location/url[@usage = 'primary'], 'ivrla_')"/>-->
    <xsl:variable name="object_id"
        select="substring-after(/mods/identifier[@type = 'uri'], 'fedora/ivrla:')"/>

    <!--<xsl:variable name="europeana_id" select="concat('ivrla_', $object_id)"/>-->
    <xsl:variable name="europeana_id"
        select="substring-after(/mods/identifier[@type = 'uri'], 'fedora/')"/>

    <xsl:variable name="resource_id"
        select="substring-after(/mods/relatedItem[@type = 'constituent'][1]/identifier[@type = 'uri'], 'ivrla:')"/>




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
            <xsl:namespace name="crm"
                >http://www.cidoc-crm.org/rdfs/cidoc_crm_v5.0.2_english_label.rdfs#</xsl:namespace>
            <xsl:namespace name="dc">http://purl.org/dc/elements/1.1/</xsl:namespace>
            <xsl:namespace name="dcat">http://www.w3.org/ns/dcat#</xsl:namespace>
            <xsl:namespace name="dcterms">http://purl.org/dc/terms/</xsl:namespace>
            <xsl:namespace name="doap">http://usefulinc.com/ns/doap#</xsl:namespace>
            <xsl:namespace name="edm">http://www.europeana.eu/schemas/edm/</xsl:namespace>
            <xsl:namespace name="foaf">http://xmlns.com/foaf/0.1/</xsl:namespace>
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

                    <!--  edm:dataProvider  -->
                    <xsl:element name="edm:dataProvider">
                        <xsl:value-of select="originInfo/place/placeTerm"/>
                    </xsl:element>

                    <!-- edm:isShownAt, id: 217 -->
                    <!-- Check for mandatory elements on edm:isShownAt -->
                    <xsl:if test="$object_id">

                        <xsl:element name="edm:isShownAt">
                            <xsl:attribute name="rdf:resource">
                                <xsl:value-of select="location/url"/>
                            </xsl:attribute>
                        </xsl:element>

                    </xsl:if>

                    <!-- Check for mandatory elements on edm:isShownBy -->
                    <!-- edm:isShownBy, id: 219 -->
                    <xsl:if test="$resource_id">
                        <xsl:element name="edm:isShownBy">
                            <xsl:attribute name="rdf:resource">
                                <xsl:value-of
                                    select="concat($baseUrl_service, $resource_id, $hqPicture)"/>
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:if>

                    <!-- Check for mandatory elements on edm:object -->
                    <!-- edm:object, id: 221 -->
                    <xsl:if test="$resource_id">
                        <xsl:element name="edm:object">
                            <xsl:attribute name="rdf:resource">
                                <xsl:value-of
                                    select="concat($baseUrl_service, $resource_id, $thumb)"
                                />
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
                        <xsl:for-each select="name[type = 'personal']/namePart">
                            <xsl:element name="dc:contributor">
                                <xsl:value-of select="."/>
                            </xsl:element>
                        </xsl:for-each>

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
                                <xsl:value-of
                                    select="
                                        concat(
                                        location/physicalLocation[@type = 'institution'],
                                        ', ',
                                        location/physicalLocation[@type = 'repository'],
                                        ', ',
                                        location/physicalLocation[@type = 'collection'],
                                        ', Ref. ',
                                        location/physicalLocation[@type = 'originalRef'])"
                                />
                            </xsl:element>
    
                            <!-- Main Description -->
                            <xsl:for-each select="note">
                                <xsl:element name="dc:description">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of select="'en'"/>
                                    </xsl:attribute>
    
                                    <xsl:value-of select="."/>
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
                            
                            <xsl:element name="dc:format">
                                <xsl:attribute name="xml:lang">
                                    <xsl:value-of select="'en'"/>
                                </xsl:attribute>
                                <xsl:value-of select="form"/>
                            </xsl:element>
                            
                            <!-- MANUALLY SELECTED FORMAT -->
                            <xsl:element name="dc:format">
                                <!--<xsl:value-of
                                    select="internetMediaType"/>-->
                                <xsl:value-of select="$format"/>
                            </xsl:element>
                            
                        </xsl:for-each>

                        <!-- dc:identifier, id: 255 -->
                            <!-- Local ID -->
                            <xsl:element name="dc:identifier">
                                <xsl:value-of select="identifier[@type = 'local']"/>
                            </xsl:element>
                        
                            <!-- EAD ID -->
                            <xsl:element name="dc:identifier">
                                <xsl:value-of
                                    select="concat('EADseries:', identifier[@type = 'EADseries'])"/>
                            </xsl:element>
                        
                            <!-- URI ID -->
                            <xsl:element name="dc:identifier">
                                <xsl:value-of select="$europeana_id"/>
                            </xsl:element>
                        
                            <!-- URI Full ID -->
                            <xsl:element name="dc:identifier">
                                <xsl:value-of
                                    select="concat('http://digital.ucd.ie/view/ivrla:', $object_id)"/>
                            </xsl:element>
                        
                            <!-- DOI ID -->
                            <xsl:element name="dc:identifier">
                                <xsl:value-of select="identifier[@type = 'doi']"/>
                            </xsl:element>

                        <!-- dc:language, id: 257 -->
                        <xsl:for-each
                            select="language/languageTerm[@type = 'code']/text() | language/scriptTerm[@type = 'code']">
                            <!-- ISO LANG ALIGNEMENT  -->
                            <!--<xsl:variable name="idx_lang"
                                select="index-of($map_lang/map, replace(., '^\s*(.+?)\s*$', '$1'))"/>-->
                            <xsl:element name="dc:language">
                                <!--<xsl:value-of select="$map_lang/map[$idx_lang]/@value"/>-->
                                <xsl:value-of select="."/>
                            </xsl:element>
                        </xsl:for-each>

                        <!-- dc:publisher, id: xxx -->
                        <xsl:element name="dc:publisher">
                            <xsl:value-of select="originInfo/publisher"/>
                        </xsl:element>

                        <!-- dc:rights, id: 265 -->
                        <xsl:for-each select="accessCondition">
                            <xsl:element name="dc:rights">
                                <xsl:attribute name="xml:lang">
                                    <xsl:value-of select="'en'"/>
                                </xsl:attribute>
                                <xsl:value-of select="."/>
                            </xsl:element>
                        </xsl:for-each>

                        <!-- dc:source, id: 268 -->
                        <xsl:element name="dc:source">
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="'en'"/>
                            </xsl:attribute>
                            <xsl:value-of select="recordInfo/recordContentSource"/>
                        </xsl:element>

                        <!-- dc:subject, id: ??? -->
                            <!-- skos:Concept -->
                            <xsl:if test="subject/@valueURI">
                                <xsl:for-each select="subject/@valueURI">
                                    <xsl:element name="dc:subject">
                                        <xsl:attribute name="rdf:resource">
                                            <xsl:value-of select="."/>
                                        </xsl:attribute>
                                    </xsl:element>
                                </xsl:for-each>
                            </xsl:if>
    
                            <!-- Litterals -->
                            <xsl:for-each select="subject">
                                <xsl:element name="dc:subject">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of select="'en'"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="concat(topic, '--', geographic)"/>
                                </xsl:element>
                            </xsl:for-each>

                        <!-- dc:title, id: 274 -->
                        <xsl:element name="dc:title">
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="'en'"/>
                            </xsl:attribute>
                            <xsl:value-of select="titleInfo/title"/>
                        </xsl:element>

                        <!-- dc:type, id: 276 -->
                            <!-- URIs -->
                            <xsl:for-each select="genre/@valueURI">
                                <xsl:element name="dc:type">
                                    <xsl:attribute name="rdf:resource" select="."/>
                                </xsl:element>
                            </xsl:for-each>
    
                            <!-- Litterals -->
                            <xsl:for-each select="genre | typeOfResource">
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
                                    <xsl:attribute name="rdf:resource"
                                        select="substring-after(identifier[@type = 'uri'], 'fedora/')"
                                    />
                                </xsl:element>
                            </xsl:for-each>
                        </xsl:if>
                        <!-- ./HIERARCHIES -->

                        <!-- dcterms:spatial, id: 335 -->
                        <!-- REMOVING THE DUPLICATES -->
                        <xsl:for-each select="distinct-values(subject/geographic)">
                            <xsl:element name="dcterms:spatial">
                                <xsl:value-of select="."/>
                            </xsl:element>
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


</xsl:stylesheet>
