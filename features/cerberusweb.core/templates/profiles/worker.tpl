{$page_context = CerberusContexts::CONTEXT_WORKER}
{$page_context_id = $dict->id}
{$is_writeable = Context_Worker::isWriteableByActor($dict, $active_worker)}

<div style="float:left;margin-right:10px;position:relative;">
	<img src="{devblocks_url}c=avatars&context=worker&context_id={$dict->id}{/devblocks_url}?v={$dict->updated}" style="height:75px;width:75px;border-radius:5px;">
	{if $dict->is_disabled}<span class="plugin_icon_overlay_disabled" style="background-size:75px 75px;"></span>{/if}
</div>

<div class="cerb-profile-header">
	<h1>
	{$dict->_label}
	
	{if $dict->gender == 'M'}
	<span class="glyphicons glyphicons-male"></span>
	{elseif $dict->gender == 'F'}
	<span class="glyphicons glyphicons-female"></span>
	{/if}
	
	{if $dict->at_mention_name}
	<small>@{$dict->at_mention_name}</small>
	{/if}
	</h1>
	
	{if $dict->title}
	<div>
		{$dict->title}
	</div>
	{/if}
	
	<div class="cerb-profile-toolbar" style="margin:5px;">
		<form class="toolbar" action="javascript:;" method="POST" style="margin:0px 0px 5px 0px;" onsubmit="return false;">
			<input type="hidden" name="_csrf_token" value="{$session.csrf_token}">
			
			<span id="spanInteractions" style="position:relative;">
			{include file="devblocks:cerberusweb.core::events/interaction/interactions_menu.tpl"}
			</span>
			
			<!-- Card -->
			<button type="button" id="btnProfileCard" title="{'common.card'|devblocks_translate|capitalize}" data-context="{$dict->_context}" data-context-id="{$dict->id}"><span class="glyphicons glyphicons-nameplate"></span></button>
			
			{if $active_worker->is_superuser && $dict->id != $active_worker->id}<button type="button" id="btnProfileWorkerPossess"><span class="glyphicons glyphicons-user"></span> Impersonate</button>{/if}
			
			{if $is_writeable && $active_worker->hasPriv("contexts.{$page_context}.update")}
			<button type="button" id="btnProfileWorkerEdit" class="cerb-peek-trigger" data-context="{CerberusContexts::CONTEXT_WORKER}" data-context-id="{$dict->id}" data-edit="true" title="{'common.edit'|devblocks_translate|capitalize}"><span class="glyphicons glyphicons-cogwheel"></span></button>
			{/if}
			
			{if !$active_worker->is_superuser && $dict->id == $active_worker->id}<button type="button" id="btnProfileWorkerSettings" title="{'common.settings'|devblocks_translate|capitalize}" onclick="document.location='{devblocks_url}c=preferences{/devblocks_url}';"><span class="glyphicons glyphicons-cogwheel"></span></button>{/if}
		</form>
		
		{if $pref_keyboard_shortcuts}
			<small>
			{$translate->_('common.keyboard')|lower}:
			{if $active_worker->is_superuser}(<b>e</b>) {'common.edit'|devblocks_translate|lower}{/if}
			(<b>1-9</b>) change tab
			</small>
		{/if}
	</div>
</div>

<fieldset class="properties">
	<legend>{'common.worker'|devblocks_translate|capitalize}</legend>
	
	<div style="margin-left:15px;">
	
	{foreach from=$properties item=v key=k name=props}
		<div class="property">
			{if $k == '...'}
				<b>{'...'|devblocks_translate|capitalize}:</b>
				...
			{else}
				{include file="devblocks:cerberusweb.core::internal/custom_fields/profile_cell_renderer.tpl"}
			{/if}
		</div>
		{if $smarty.foreach.props.iteration % 3 == 0 && !$smarty.foreach.props.last}
			<br clear="all">
		{/if}
	{/foreach}
	</div>
	
	<br clear="all">
</fieldset>

{include file="devblocks:cerberusweb.core::internal/custom_fieldsets/profile_fieldsets.tpl" properties=$properties_custom_fieldsets}

{include file="devblocks:cerberusweb.core::internal/profiles/profile_record_links.tpl" properties=$properties_links links_label="{'common.watching'|devblocks_translate|capitalize}"}

<div>
{include file="devblocks:cerberusweb.core::internal/notifications/context_profile.tpl" context=$page_context context_id=$page_context_id}
</div>

<div>
{include file="devblocks:cerberusweb.core::internal/macros/behavior/scheduled_behavior_profile.tpl" context=$page_context context_id=$page_context_id}
</div>

<div id="profileWorkerTabs">
	<ul>
		{$tabs = []}
		{$point = "cerberusweb.profiles.worker.{$dict->id}"}
		
		{if !$dict->is_disabled}
			{$tabs[] = 'responsibilities'}
			<li data-alias="responsibilities"><a href="{devblocks_url}ajax.php?c=internal&a=handleSectionAction&section=responsibilities&action=showResponsibilitiesTab&point={$point}&context={$page_context}&context_id={$page_context_id}{/devblocks_url}">{'common.responsibilities'|devblocks_translate|capitalize}</a></li>
		
			{if DAO_Skill::count()}
			{$tabs[] = 'skills'}
			<li data-alias="skills"><a href="{devblocks_url}ajax.php?c=internal&a=handleSectionAction&section=skills&action=showSkillsTab&point={$point}&context={$page_context}&context_id={$page_context_id}{/devblocks_url}">{'common.skills'|devblocks_translate|capitalize}</a></li>
			{/if}
			
			{$tabs[] = 'calendar'}
			<li data-alias="calendar"><a href="{devblocks_url}ajax.php?c=internal&a=handleSectionAction&section=calendars&action=showCalendarTab&point={$point}&context={$page_context}&context_id={$page_context_id}&id={$dict->calendar_id}{/devblocks_url}">{'common.calendar'|devblocks_translate|capitalize}</a></li>
	
			{$tabs[] = 'availability'}
			<li data-alias="availability"><a href="{devblocks_url}ajax.php?c=internal&a=handleSectionAction&section=calendars&action=showCalendarAvailabilityTab&point={$point}&context={$page_context}&context_id={$page_context_id}&id={$dict->calendar_id}{/devblocks_url}">{'common.availability'|devblocks_translate|capitalize}</a></li>
		{/if}
		
		{$tabs[] = 'activity'}
		<li data-alias="activity"><a href="{devblocks_url}ajax.php?c=internal&a=showTabActivityLog&scope=both&point={$point}&context={$page_context}&context_id={$page_context_id}{/devblocks_url}">{'common.activity_log'|devblocks_translate|capitalize}</a></li>
		
		{$tabs[] = 'comments'}
		<li data-alias="comments"><a href="{devblocks_url}ajax.php?c=internal&a=showTabContextComments&context={$page_context}&id={$page_context_id}{/devblocks_url}">{'common.comments'|devblocks_translate|capitalize} <div class="tab-badge">{DAO_Comment::count($page_context, $page_context_id)|default:0}</div></a></li>

		{if $active_worker->is_superuser || $dict->id == $active_worker->id}
		{$tabs[] = 'attendants'}
		<li data-alias="attendants"><a href="{devblocks_url}ajax.php?c=internal&a=showAttendantsTab&point={$point}&context={$page_context}&context_id={$page_context_id}{/devblocks_url}">{'common.bots'|devblocks_translate|capitalize}</a></li>
		{/if}
		
		{if $active_worker->is_superuser || $dict->id == $active_worker->id}
		{$tabs[] = 'snippets'}
		<li data-alias="snippets"><a href="{devblocks_url}ajax.php?c=internal&a=showTabSnippets&point={$point}&context={$page_context}&context_id={$page_context_id}{/devblocks_url}">{'common.snippets'|devblocks_translate|capitalize}</a></li>
		{/if}
		
		{foreach from=$tab_manifests item=tab_manifest}
			{$tabs[] = $tab_manifest->params.uri}
			<li data-alias="{$tab_manifest->params.uri}"><a href="{devblocks_url}ajax.php?c=profiles&a=showTab&ext_id={$tab_manifest->id}&point={$point}&context={$page_context}&context_id={$page_context_id}{/devblocks_url}"><i>{$tab_manifest->params.title|devblocks_translate}</i></a></li>
		{/foreach}
	</ul>
</div> 
<br>

<script type="text/javascript">
$(function() {
	var tabOptions = Devblocks.getDefaultjQueryUiTabOptions();
	tabOptions.active = Devblocks.getjQueryUiTabSelected('profileWorkerTabs', '{$tab}');
	
	var tabs = $("#profileWorkerTabs").tabs(tabOptions);
	
	// Interactions
	var $interaction_container = $('#spanInteractions');
	{include file="devblocks:cerberusweb.core::events/interaction/interactions_menu.js.tpl"}
	
	// Card
	$('#btnProfileCard')
		.cerbPeekTrigger()
	;
	
	// Edit
	
	{if $active_worker->is_superuser}
	$('#btnProfileWorkerEdit')
		.cerbPeekTrigger()
		.on('cerb-peek-opened', function(e) {
		})
		.on('cerb-peek-saved', function(e) {
			e.stopPropagation();
			document.location.reload();
		})
		.on('cerb-peek-deleted', function(e) {
			document.location.href = '{devblocks_url}{/devblocks_url}';
			
		})
		.on('cerb-peek-closed', function(e) {
		})
		;
	{/if}
	
	// Impersonate
	
	$('#btnProfileWorkerPossess').click(function() {
		genericAjaxGet('','c=internal&a=su&worker_id={$dict->id}',function(o) {
			window.location = window.location;
		});
	});
});
</script>

<script type="text/javascript">
{if $pref_keyboard_shortcuts}
$(function() {
	$(document).keypress(function(event) {
		if(event.altKey || event.ctrlKey || event.shiftKey || event.metaKey)
			return;
		
		if($(event.target).is(':input'))
			return;
	
		var hotkey_activated = true;
		
		switch(event.which) {
			case 49:  // (1) tab cycle
			case 50:  // (2) tab cycle
			case 51:  // (3) tab cycle
			case 52:  // (4) tab cycle
			case 53:  // (5) tab cycle
			case 54:  // (6) tab cycle
			case 55:  // (7) tab cycle
			case 56:  // (8) tab cycle
			case 57:  // (9) tab cycle
			case 58:  // (0) tab cycle
				try {
					var idx = event.which-49;
					var $tabs = $("#profileWorkerTabs").tabs();
					$tabs.tabs('option', 'active', idx);
				} catch(ex) { }
				break;
			case 101:  // (E) edit
				try {
					$('#btnProfileWorkerEdit').click();
				} catch(ex) { }
				break;
			case 109:  // (M) macros
				try {
					$('#btnDisplayMacros').click();
				} catch(ex) { }
				break;
			default:
				// We didn't find any obvious keys, try other codes
				hotkey_activated = false;
				break;
		}
		
		if(hotkey_activated)
			event.preventDefault();
	});
});
{/if}
</script>

{include file="devblocks:cerberusweb.core::internal/profiles/profile_common_scripts.tpl"}