function Show-Usage() {
    Write-Host "Usage: please provide a comma-separated list of integers"
    Exit(1)
}

function Parse-IntList([string]$Str) {
    @($Str.Split(",") | ForEach-Object { [int]::Parse($_) })
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

class MstItem {
    [int]$SrcIndex
    [int]$DestIndex
    [int]$Weight

    MstItem([int]$srcIndex, [int]$destIndex, [int]$weight) {
        $this.SrcIndex = $srcIndex
        $this.DestIndex = $destIndex
        $this.Weight = $weight
    }
}

# Prim's Minimum Spanning Tree (MST) Algorithm based on C implementation of
# https://www.geeksforgeeks.org/prims-minimum-spanning-tree-mst-greedy-algo-5/
function Invoke-PrimMst([Node[]]$Graph) {
    $numVertices = $Graph.Length

    # Array to store constructed MST. Indicate no parents yet
    $parents = @(-1) * $numVertices

    # Key values used to pick minimum weight edge. Initialize to infinity
    $keys = @([int]::MaxValue) * $numVertices

    # Indicate nothing in MST yet
    $mstSet = @($false) * $numVertices

    # Include first vertex in MST
    $keys[0] = 0

    # The MST will include all vertices
    for ($i = 1; $i -lt $numVertices; $i++) {
        # Pick index of the minimum key value not already in MST
        $u = Find-MinKey $keys $mstSet

        # Add picked vertex to MST
        $mstSet[$u] = $true

        # Update key values and parent indices of picked adjacent
        # vertices. Only consider vertices not yet in MST
        foreach ($child in $Graph[$u].Children) {
            $v = $child.Index
            $w = $child.Weight
            if (-not $mstSet[$v] -and $w -lt $keys[$v]) {
                $parents[$v] = $u
                $keys[$v] = $w
            }
        }
    }

    # Construct MST information to return, skipping over root
    @(1..($numVertices - 1) | ForEach-Object { [MstItem]::new($parents[$_], $_, $keys[$_]) })
}

function Find-MinKey([int[]]$Keys, [bool[]]$MstSet) {
    $minValue = [int]::MaxValue
    $minIndex = -1
    for ($v = 0; $v -lt $Keys.Length; $v++) {
        if ($Keys[$v] -lt $minValue -and -not $MstSet[$v]) {
            $minValue = $Keys[$v]
            $minIndex = $v
        }
    }

    $minIndex
}

function Invoke-MstTotalWeight([MstItem[]]$mst) {
    ($mst.Weight | Measure-Object -Sum).Sum
}

if ($args.Length -lt 1 -or -not $args[0]) {
    Show-Usage
}

try {
    $weights = Parse-IntList $args[0]
} catch {
    Show-Usage
}

$numVertices = [int][Math]::Floor([Math]::Sqrt($weights.Length))
if ($weights.Length -ne $numVertices * $numVertices) {
    Show-Usage
}

# Create graph from weights
$graph = Create-Graph $weights $numVertices

# Get MST using Prim's algorithm
$mst = Invoke-PrimMst $graph

# Calculate total weight of MST
$totalWeight = Invoke-MstTotalWeight $mst
Write-Output $totalWeight
