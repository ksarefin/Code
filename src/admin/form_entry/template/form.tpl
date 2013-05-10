<div id="pageTtl">
<h2>フォーム編集 &gt; ページ &gt; フォーム編集 &gt; {$page_title}{if !empty($pd.id)}
編集
{else}
追加
{/if}</h2>
</div>

{literal}
<script type="text/javascript">
//<!CDATA[
          
    j$(document).ready(function(){

    	j$("#preview").click(function() {
    		
    		var url_params = 'form_id/{/literal}{$form_id|make_id}{literal}/set_id/{/literal}{$set_id|make_id}{literal}/type/{/literal}{$entry_type|make_id}{literal}';
        	var post_url = '{/literal}{$self}{literal}/preview/'+url_params;
			var values = j$('#frm').serialize();

			j$.ajax({
			   url: post_url,
			   data: values,
			   success: function(get_html){
				  //alert(get_html);  
			   	  j$("#preview_html").html(get_html);
			   }
			});
		});

  
    	 	var counter;
    	    
    	    if ({/literal}{$pd.options|count}{literal}){
    	    	counter = {/literal}{$pd.options|count}{literal};
    	    	counter = counter+1;   
    	    }else{
    	    	counter = 3;
    	    }
    	 
    	    j$("#addButton").click(function () {

        	    var name = j$("#addButton").attr("name");

        	    //alert(name);
        	    
    	 		var newTextBoxDiv = j$(document.createElement('div'))
	    			 .attr("class", 'option'+counter+'_'+name)
	    		     .attr("id", 'option'+counter+'_'+name+'_id');
	    	 
	    		newTextBoxDiv.after().html('<input type="text" name="pd[options][]" size="60" class="text" id="option'+counter+'_id" maxlength="50" />');
	    	 
	    		newTextBoxDiv.appendTo("#options_"+name);
	    	 
	    	 
	    		counter++;
    	     });
    	 


      	    j$("#removeButton").click(function () {

      	    	var name = j$("#addButton").attr("name");
      	    	
      	    	if(counter==3){
    	          return false;
    	     	}   
    	 
	    		counter--;
	    	 
	    	     j$("#option" + counter+'_'+name+'_id').remove();
	    	 
    	   });


      	var options_count;

      	if ({/literal}{$options_count}{literal}){
      		options_count = {/literal}{$options_count}{literal};
      		options_count = options_count + 1 ; 
	    }else{
	    	options_count = 1;
	    }

        j$("#add_yn_field").click(function(){

            var field_type = j$("#ynSelect").val();

            var field_div = j$(document.createElement('div'))
			 .attr("class", '')
		     .attr("id", 'field_div_id');

		    var url_params = 'type/'+field_type+'/count/'+options_count;
        	var post_url = '{/literal}{$self}{literal}/ynFieldHtml/'+url_params;
			//alert(post_url);
			
			j$.ajax({
			   url: post_url,
			   success: function(get_html){
				  //alert(get_html);
				  if (get_html){
					field_div.after().html(''+get_html+''); 
				  	field_div.appendTo("#add_yn_field_html");
				  	options_count ++;
				  }
			   }
			});

        });

             	   
  
		
    });
    
//]]>
</script>
{/literal}


<div class="formBox01">

{if !empty($err)}
<ul class="errorList">
{foreach from=$err item=val}
<li>{$val}</li>
{/foreach}
</ul>
{/if}

<div id="pageSubTtl">
<h3>{$pd.label}</h3>
</div>

<form name="frm" id="frm" method="post" action="{$self}/save/form_id/{$form_id|make_id}/set_id/{$set_id|make_id}/type/{$entry_type|make_id}" enctype="multipart/form-data">
<input type="hidden" name='pd[id]' value="{$pd.id}" />
<input type="hidden" name='pd[type]' value="{$pd.type}" />
<input type="hidden" name='pd[name]' value="{$pd.name}" />

<p class="caption" style="float:right;">updated: {$pd.update_date|date_format:"%Y-%m-%d %H:%M:%S"}</p>
<p class="left caption"><span class="require">※</span>は必須項目です</p>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="wpfTblAdm">

<tr>
<th width="200" scope="row">id</th>
<td>{$pd.id}</td>
</tr>

<tr>
<th scope="row">フィールド名</th>
<td>{$pd.name}</td>
</tr>

</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="wpfTblAdm">
{$form_html}
</table>

<ul class="btnList">
<li><a href="{$list_page_url}" class="btnMgrList"><span>項目一覧</span></a></li>
<li><input type="button" name="preview" id="preview" class="btnPreview" value="プレビュー" /> </li>
<li><input type="submit" name="submit" id="submit" class="btnGreenB" value="保存" /></li>
</ul>

<p class="left caption">＜マークアップ用設定項目＞</p>
<div class="clearfix">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="wpfTblAdm">
{$common_html}
</table>
</div>

</form>

<p class="left caption">＜プレビュー＞</p>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="wpfTblAdm" id="preview_html">
</table>

</div><!-- /formBox01 -->
