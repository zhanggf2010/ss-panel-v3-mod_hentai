{include file='user/main.tpl'}
	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">流量記錄</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="ui-card-wrap">
					<div class="row">
						<div class="col-lg-12 col-sm-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">注意!</p>
										<p>部分節點不支持流量記錄.</p>
										<p>此處只展示最近 72 小時的記錄，粒度爲分鍾。</p>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-12 col-sm-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<div id="log_chart" style="height: 300px; width: 100%;"></div>
										<script src="//canvasjs.com/assets/script/canvasjs.min.js"> </script>
										<script type="text/javascript">
											window.onload = function () {
												var log_chart = new CanvasJS.Chart("log_chart",
												{
													zoomEnabled: true,
													title:{
														text: "您的最近72小時流量消耗",
														fontSize: 20
													},
													animationEnabled: true,
													axisX: {
														title:"時間",
														labelFontSize: 14,
														titleFontSize: 18
													},
													axisY:{
														title: "流量/KB",
														lineThickness: 2,
														labelFontSize: 14,
														titleFontSize: 18
													},
													data: [
													{
														type: "scatter",
														{literal}
														toolTipContent: "<span style='\"'color: {color};'\"'><strong>産生時間: </strong></span>{x} <br/><span style='\"'color: {color};'\"'><strong>流量: </strong></span>{y} KB <br/><span style='\"'color: {color};'\"'><strong>産生節點: </strong></span>{jd}",
														{/literal}
														dataPoints: [
														{$i=0}
														{foreach $logs as $single_log}
															{if $i==0}
																{literal}
																{
																{/literal}
																	x: new Date({$single_log->log_time*1000}), y:{$single_log->totalUsedRaw()},jd:"{$single_log->node()->name}"
																{literal}
																}
																{/literal}
																{$i=1}
															{else}
																{literal}
																,{
																{/literal}
																	x: new Date({$single_log->log_time*1000}), y:{$single_log->totalUsedRaw()},jd:"{$single_log->node()->name}"
																{literal}
																}
																{/literal}
															{/if}
														{/foreach}
														]
													}
													]
												});
											log_chart.render();
										}
										</script>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</main>
{include file='user/footer.tpl'}
