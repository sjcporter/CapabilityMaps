<#ftl encoding="utf-8" />
<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/web/templates/modernui/funnelback.ftl" as fb/>
<#--<@s.AfterSearchOnly></@s.AfterSearchOnly>
<@s.OpenSearch></@s.OpenSearch>
  <@s.InitialFormOnly></@s.InitialFormOnly>--> 
ipretResults({ "results":[<@s.Results>
<#if s.result.class.simpleName == "TierBar"><#if s.result.matched == s.result.outOf><#else></#if><#else>
        <#-- METADATA SUMMARIES -->
        <#macro idclean id>
          <#assign id = id?replace(".","")>
          <#assign id = id?replace("/","")>
          <#assign id = id?replace(":","")>
            ${id}
          <#return>
         </#macro>    
        
        <#macro cleanmetadata metadata>
          <#assign x = metadata?replace("<p>","")>
          <#assign x = x?replace("</p>","")>
          <#assign x = x?replace("<br/>","")>
            <#assign x = x?replace("<br />","")>
              <#assign x = x?replace("<strong>","<b>")>
                <#assign x = x?replace("</strong>","</b>")>
              <#assign x = x?replace('\"','\\\"')>${x}<#return>
       </#macro>
            
      <#function filter metadataList>
          <#local result = []>
            <#list metadataList as x><#local result = result + [x]></#list>
       <#return result>
     </#function>
        
         <#macro listmetadata metalist><#assign firstFlag = "N"/><#list filter(metalist?split("|")) as x><#if  x?contains("<strong>")><#if firstFlag="Y">,</#if><#assign firstFlag = "Y"/>"<@cleanmetadata x/>"</#if></#list></#macro>
                      
         <#macro listmetadataNF metalist><#assign firstFlag = "N"/><#list filter(metalist?split("|")) as x><#if firstFlag="Y">,</#if><#assign firstFlag = "Y"/>"<@cleanmetadata x/>"</#list></#macro>
         
        <#macro processClusters pclusters>
<#local x><#list pclusters as pc>,"${pc.query?replace(' ','%20')?replace('\"','%22')?replace('[','%5B')?replace(']','%5D')?replace('#','%23')}"</#list></#local>${x?substring(1)}</#macro>

         <#if s.result.metaData["4"]?exists>                   
         <#assign rid='${s.result.displayUrl?replace("http://www.findanexpert.unimelb.edu.au/individual/person","")}'>
             {"md_1":"${rid}"
           <#if s.result.metaData["1"]?exists>,"md_Z":"${s.result.metaData["1"]?split(" ")[0]}"</#if>
             <#if s.result.metaData["A"]?exists>,"md_A":"${s.result.metaData["A"]!}"</#if> 
             <#if s.result.metaData["B"]?exists>,"md_B":"${s.result.metaData["B"]!}"</#if>
             <#if s.result.metaData["4"]?exists>,"md_4":"${s.result.metaData["4"]!}"</#if> 
             <#if s.result.metaData["3"]?exists>,"md_3":"${s.result.metaData["3"]!}"</#if> 
           ,"query":"<@cleanmetadata question.query?replace(' ','%20')?replace('\"','%22')?replace('[','%5B')?replace(']','%5D')?replace('#','%23')/>" 
           <#if response.resultPacket.contextualNavigation.categories[0]?exists>,"clusters":[<@processClusters response.resultPacket.contextualNavigation.categories[0].clusters/><#if response.resultPacket.contextualNavigation.categories[1]?exists>,<#else>]</#if></#if>
           <#if response.resultPacket.contextualNavigation.categories[1]?exists><#if !(response.resultPacket.contextualNavigation.categories[0]?exists)>[</#if><@processClusters response.resultPacket.contextualNavigation.categories[1].clusters/>]</#if>
           },</#if></#if>
     </@s.Results>{}]
               
               });         

        
    
