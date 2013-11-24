CKEDITOR.editorConfig = function( config )
{
	config.contentsCss = ['/assets/styles/styles.css','/assets/styles/client.css'];
	config.docType = '<!DOCTYPE html>';
	config.forcePasteAsPlainText = true;
	config.tabSpaces = 4;
	config.baseHref = "../";
	config.height = 120;
	config.toolbar =
		[
			{ name: 'document',    items : [ 'Source' ] },
			{ name: 'tools',       items : [ 'Maximize', 'ShowBlocks','-','Cut','Copy','Paste'] },
			{ name: 'links',       items : [ 'NumberedList','BulletedList','-','Link','Unlink','-','Image','Table','SpecialChar' ] },
			{ name: 'paragraph',   items : [ 'JustifyLeft','JustifyCenter','JustifyRight'] },
			'/',
			{ name: 'colors',      items : [ 'TextColor','BGColor' ] },
			{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','-','RemoveFormat' ] },
			{ name: 'styles',      items : [ 'Format','Font','FontSize' ] }
		];
};