function Show-Usage() {
    Write-Host "Usage: please provide three inputs: a serialized matrix, a source node and a destination node"
    Exit(1)
}

function Parse-IntList([string]$Str) {
    @($Str.Split(",") | ForEach-Object { [int]::Parse($_) })
}

function Test-Inputs([array]$Weights, [int]$NumVertices, [int]$Src, [int]$Dest) {
    # Verify number of weights is a square, weights are non-negative, any non-zero weight, and source
    # destination are valid
    $WeightMeasurements = $Weights | Measure-Object -Minimum -Maximum
    ($Weights.Length -eq ($NumVertices * $NumVertices) -and
        $WeightMeasurements.Minimum -ge 0 -and
        $WeightMeasurements.Maximum -gt 0 -and
        $Src -ge 0 -and $Src -lt $NumVertices -and
        $Dest -ge 0 -and $Dest -lt $NumVertices)
}

class NodeItem {
    [int]$Index
    [int]$Weight

    NodeItem([int]$index, [int]$weight) {
        $this.Index = $index
        $this.Weight = $weight
    }
}

class Node {
    [int]$Index
    [NodeItem[]]$Children

    Node([int]$index) {
        $this.Index = $index
        $this.Children = @()
    }

    [void] AddChild([int]$index, [int]$weight) {
        $this.Children += [NodeItem]::new($index, $weight)
    }
}

function Create-Graph([array]$Weights, [int]$NumVertices) {
    # Initialize nodes
    $nodes = 0..($NumVertices - 1) | ForEach-Object { [Node]::new($_) }

    # Get neighbors for this node based on weights
    $index = 0
    for ($row = 0; $row -lt $NumVertices; $row++) {
        for ($col = 0; $col -lt $NumVertices; ($col++), ($index++)) {
            if ($Weights[$index] -gt 0) {
                $nodes[$row].AddChild($col, $Weights[$index])
            }
        }
    }

    $nodes
}

class DijkstraItem {
    [int]$Prev = -1
    [int]$Dist = [int]::MaxValue
}

# Source: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode
function Invoke-Dijkstra([Node[]]$Graph, [int]$Src) {
    # Initialize distances to infinite and previous vertices to undefined
    $numVertices = $Graph.Length
    $results = 0..($numVertices - 1) | ForEach-Object { [DijkstraItem]::new() }

    # Indicate all nodes unvisited
    $q = [Collections.Generic.HashSet[int]](0..($numVertices - 1))

    # Set source vertex distance to 0
    $results[$Src].Dist = 0

    # While there are unvisited nodes
    while ($q.Count) {
        # Pick a vertex u with minimum distance from unvisited nodes
        $u = Find-MinDistIndex $q $results

        # Indicate vertex u visited
        [void]$q.Remove($u)

        # For each unvisited neighbor v of vertex u
        foreach ($node in $Graph[$u].Children) {
            $v = $node.Index
            if ($v -in $q) {
                # Get trial distance
                $alt = $results[$u].Dist + $node.Weight

                # If trial distance is smaller than distance v, update distance to v and
                # previous vertex of v
                if ($alt -lt $results[$v].Dist) {
                    $results[$v].Dist = $alt
                    $results[$v].Prev = $u
                }
            }
        }
    }

    $results
}

function Find-MinDistIndex([Collections.Generic.HashSet[int]]$q, [DijkstraItem[]]$results) {
    $minDist = [int]::MaxValue
    $minIndex = -1
    for ($v = 0; $v -lt $results.Length; $v++) {
        if ($v -in $q -and $results[$v].Dist -lt $minDist) {
            $minDist = $results[$v].Dist
            $minIndex = $v
        }
    }

    $minIndex
}

if ($args.Length -lt 3 -or -not $args[0]) {
    Show-Usage
}

try {
    $weights = Parse-IntList $args[0]
    $src = [int]::Parse($args[1])
    $dest = [int]::Parse($args[2])
} catch {
    Show-Usage
}


$numVertices = [int][Math]::Floor([Math]::Sqrt($weights.Length))
if (-not (Test-Inputs $weights $numVertices $src $dest)) {
    Show-Usage
}

# Create graph from weights
$graph = Create-Graph $weights $numVertices

# Run Dijkstra's algorithm on graph and show distance to destination
$results = Invoke-Dijkstra $graph $src
Write-Output $results[$dest].Dist
