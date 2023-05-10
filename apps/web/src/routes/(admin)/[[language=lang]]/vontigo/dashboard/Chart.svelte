<!-- Chart.svelte -->
<script lang='ts'>
	import { onMount } from 'svelte';
	import * as d3 from 'd3';

	export let data;
	// console.log(JSON.stringify(data));

	onMount(() => {
		const margin = { top: 20, right: 20, bottom: 30, left: 30 };
		const width =
			parseInt(d3.select('#chart-container').style('width')) - margin.left - margin.right;
		const height =
			parseInt(d3.select('#chart-container').style('height')) - margin.top - margin.bottom;
        
            // Parse the date/time
        const parseDate = d3.timeParse("%Y%m%d");

		const svg = d3
			.select('#chart-container')
			.append('svg')
			.attr(
				'viewBox',
				`0 0 ${width + margin.left + margin.right} ${height + margin.top + margin.bottom}`
			)
			.append('g')
			.attr('transform', `translate(${margin.left}, ${margin.top})`);

		const x = d3.scaleTime().range([0, width]);

		const y = d3.scaleLinear().range([height, 0]);

		const line = d3
			.line()
			.x((d) => x(d.date))
			.y((d) => y(d.visits));

			data.forEach((d) => {
                d.date = parseDate(d[0]);
                d.visits = +d[1];
			});

			x.domain(d3.extent(data, (d) => d.date));
			y.domain([0, d3.max(data, (d) => d.visits)]);

			svg.append('path').datum(data)
            .attr("fill", "none")
                .attr("stroke", "steelblue")
                .attr("stroke-width", 2).attr('d', line);

			svg.append('g').attr('transform', `translate(0, ${height})`).call(d3.axisBottom(x));

			svg.append('g').call(d3.axisLeft(y));

			// Add a listener to adjust the chart dimensions on resize
			window.addEventListener('resize', () => {
				const width =
					parseInt(d3.select('#chart-container').style('width')) - margin.left - margin.right;
				const height =
					parseInt(d3.select('#chart-container').style('height')) - margin.top - margin.bottom;

				svg.attr(
					'viewBox',
					`0 0 ${width + margin.left + margin.right} ${height + margin.top + margin.bottom}`
				);

				x.range([0, width]);
				y.range([height, 0]);

				svg.select('.line').attr('d', line);
				svg.select('.x-axis').call(d3.axisBottom(x));
				svg.select('.y-axis').call(d3.axisLeft(y));
			});
	});
</script>
<div id="chart-container" class="w-full h-56">
    <!-- <svg bind:this={svg} /> -->
</div>
<style>
      
    </style>