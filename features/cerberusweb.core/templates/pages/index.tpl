<div style="margin-top:5px;"></div>

<form action="#" onsubmit="return false;">
<div class="help-box" style="padding:5px;border:0;">
	<h1 style="margin-bottom:5px;text-align:left;">Let's add some pages to your menu</h1>
	
	<p>
		Pages allow you to build a completely personalized interface based on your needs.
		
		Your most frequently used pages can be added to the menu above by clicking on the <button type="button"><span class="glyphicons glyphicons-circle-ok" style="color:rgb(0,180,0);"></span></button> button.
	</p>

	{if $active_worker->hasPriv("contexts.{CerberusContexts::CONTEXT_WORKSPACE_PAGE}.create")}
	<p>
		New pages can be added by clicking on the <span class="glyphicons glyphicons-circle-plus"></span> icon in the <span class="help callout-worklist">Pages</span> list below.
	</p>
	{/if}
	
	{if $active_worker->hasPriv("contexts.{CerberusContexts::CONTEXT_WORKSPACE_PAGE}.create")}
	<p style="margin-top:10px;">
		<a href="javascript:;" onclick="genericAjaxPopup('peek','c=pages&a=showPageWizardPopup&view_id={$view->id}',null,true,'500');" style="font-weight:bold;">Help me create a page!</a>
	</p>
	{/if}
</div>
</form>

<div style="float:left;">
	<h2>Pages</h2>
</div>

<div style="float:right;">
	{include file="devblocks:cerberusweb.core::search/quick_search.tpl" view=$view return_url=null reset=false}
</div>

<div style="clear:both;"></div>

{include file="devblocks:cerberusweb.core::internal/views/search_and_view.tpl" view=$view}