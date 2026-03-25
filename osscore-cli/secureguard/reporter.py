from rich.console import Console
from rich.panel import Panel
from rich.table import Table
from rich.text import Text

console = Console()

class Reporter:
    @staticmethod
    def display(package, score_info, data, is_cached=False):
        score = score_info if isinstance(score_info, int) else score_info.get('score', 0)
        label = "SAFE ✅" if score >= 80 else "HIGH RISK ❌" # Simple fallback
        if not isinstance(score_info, int):
            label = score_info.get('label', label)

        # Header Panel
        color = "green" if score >= 80 else "yellow" if score >= 60 else "red"
        panel_content = Text.assemble(
            (f"📦 {package}\n", "bold white"),
            (f"Score: {score}/100 ", f"bold {color}"),
            (f"[{label}]", f"bold {color}")
        )
        
        console.print(Panel(panel_content, border_style=color, title="SecureGuard Audit"))

        if is_cached:
            console.print("[italic cyan]Showing cached results from local database[/italic cyan]\n")

        # Vulnerabilities Table
        vulns = data.get('vulnerabilities', [])
        if vulns:
            table = Table(title="Vulnerabilities Found")
            table.add_column("ID", style="dim")
            table.add_column("Severity")
            table.add_column("Description")
            
            for v in vulns:
                table.add_row(
                    v.get('id', 'N/A'),
                    Reporter._get_severity_color(v),
                    v.get('details', 'No description')[:100] + "..."
                )
            console.print(table)
        else:
            console.print("[bold green]✅ No known vulnerabilities found in OSV.dev[/bold green]")

        # Metadata Summary
        metadata = data.get('metadata', {})
        if metadata:
            console.print(f"\n[bold]Version:[/bold] {metadata.get('version', 'Unknown')}")
            console.print(f"[bold]Author:[/bold] {metadata.get('author', 'Unknown')}")
            console.print(f"[bold]Home Page:[/bold] {metadata.get('home_page', 'N/A')}")
        
        console.print("\n")

    @staticmethod
    def display_bulk(filename, results):
        table = Table(title=f"Bulk Audit Report: {filename}")
        table.add_column("Package", style="bold cyan")
        table.add_column("Score", justify="center")
        table.add_column("Verdict")
        
        for p, score_info, data in results:
            score = score_info['score']
            color = "green" if score >= 80 else "yellow" if score >= 60 else "red"
            label = "SAFE ✅" if score >= 80 else "CRITICAL ❌"
            table.add_row(p, f"[{color}]{score}/100[/{color}]", f"[{color}]{label}[/{color}]")
        
        console.print("\n")
        console.print(Panel(table, border_style="blue"))
        console.print(f"[bold green]Successfully audited {len(results)} packages.[/bold green]\n")

    @staticmethod
    def _get_severity_color(vuln):
        # OSV might not have a direct "severity" string easily accessible in the same way for all
        # This is a simplification
        return "[bold red]CRITICAL[/bold red]"
