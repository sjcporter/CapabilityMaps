<#ftl encoding="utf-8" />

<#assign regularExpression = question.query?replace(".", " ")?replace("^\\s+", "", "r")?replace("\\s+$", "", "r")?replace("\\s+", " ", "r")>
<#assign regularExpression = "(?i)\\b${regularExpression}\\b">
  <#list 1..100 as i>
    <#if !regularExpression?matches(".*\"([a-zA-Z+-]+)\\s([a-zA-Z\\s-]+)\".*")>
      <#break>
      </#if>
        <#assign regularExpression = regularExpression?replace("\"([a-zA-Z+-]+)\\s([a-zA-Z\\s-]+)\"", "\"$1+$2\"", "r")>
  </#list>
<#assign regularExpression = regularExpression
?replace("\"", "")
?replace("\\s+", "|", "r")
?replace("[", "")?replace("]", "")
?replace("+", " ")
?replace("*", "[a-zA-Z]*")
?replace("|", "\\b|\\b")
!> 
<#function boldicize content bold=""><#compress>
   <#if bold != "">
     <#return tagify("strong", bold, content)>
   <#else>
       <#-- Pass the regular expression returned by PADRE -->
         
       
       <#-- Modify the regular expression here --> 
         <#return tagify("strong", regularExpression, content, true)>
   </#if>
</#compress></#function>
     
<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/web/templates/modernui/funnelback.ftl" as fb/>
<#--<@s.AfterSearchOnly></@s.AfterSearchOnly>
<@s.OpenSearch></@s.OpenSearch>
  <@s.InitialFormOnly></@s.InitialFormOnly>--> 
ipretFullResults({ "results":[<@s.Results>
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
          <#assign x = x?replace('\"','\\"')>${x}<#return>
                    
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
             <#if s.result.metaData["Z"]?exists>,"md_Z":"${s.result.metaData["Z"]!}"</#if> 
             <#if s.result.metaData["A"]?exists>,"md_A":"${s.result.metaData["A"]!}"</#if> 
             <#if s.result.metaData["B"]?exists>,"md_B":"${s.result.metaData["B"]!}"</#if>
             <#if s.result.metaData["4"]?exists>,"md_4":"${s.result.metaData["4"]!}"</#if>      
           <#if s.result.metaData["X"]?exists>
             ,"md_X":[<@listmetadataNF boldicize(s.result.metaData["X"])/>]
           </#if>
               <#if s.result.metaData["U"]?exists>
                 <#assign md_U = boldicize(s.result.metaData["U"])>
                 <#if md_U?contains("<strong>")>,"md_U":[<@listmetadata md_U! />]</#if>
           </#if>
             <#if s.result.metaData["8"]?exists>
               <#assign md_8 = boldicize(s.result.metaData["8"])>
               <#if md_8?contains("<strong>")>,"md_8":[<@listmetadata md_8! />]</#if>
                   </#if> 
           <#if s.result.metaData["W"]?exists>
             <#assign md_W = boldicize(s.result.metaData["W"])>
             <#if md_W?contains("<strong>")>,"md_W":[<@listmetadata md_W!/>]</#if>
                 </#if>  
           ,"query":"<@cleanmetadata question.query?replace(' ','%20')?replace('\"','%22')?replace('[','%5B')?replace(']','%5D')?replace('#','%23')/>"
          
           <#if response.resultPacket.contextualNavigation.categories[0]?exists>,"clusters":[<@processClusters response.resultPacket.contextualNavigation.categories[0].clusters/>]</#if>
           
           
            },</#if></#if>
     </@s.Results>{}]
               
               });         

        
    
