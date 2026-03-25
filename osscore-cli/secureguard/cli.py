import click
import sys
import os
from .scanner import Scanner
from .scoring import Scorer
from .reporter import Reporter
from .cache import Cache

@click.group()
def main():
    """SecureGuard CLI: OSS Security Scoring Tool."""
    pass

@main.command()
@click.argument('package')
@click.option('--ecosystem', default='pypi', help='Ecosystem (pypi/npm)')
@click.option('--pip', is_flag=True, help='Force pypi ecosystem')
@click.option('--npm', is_flag=True, help='Force npm ecosystem')
def scan(package, ecosystem, pip, npm):
    """Scan a package or requirements file for security risks."""
    if pip: ecosystem = 'pypi'
    if npm: ecosystem = 'npm'
    
    # Handle requirements.txt
    if package.endswith('.txt') and os.path.exists(package):
        with open(package, 'r') as f:
            packages = [line.split('>')[0].split('=')[0].strip() for line in f if line.strip() and not line.startswith('#')]
        
        click.secho(f"📋 Bulk scanning {len(packages)} packages from {package}...", fg='cyan')
        results = []
        for p in packages:
            # Re-call scan logic internally for each package
            scanner = Scanner(p, ecosystem)
            data = scanner.fetch_all()
            scorer = Scorer(data)
            score_info = scorer.calculate()
            results.append((p, score_info, data))
        
        # Display summary report
        Reporter.display_bulk(package, results)
        return

    cache = Cache()
    cached_result = cache.get(package, ecosystem)
    
    if cached_result:
        click.secho("Loaded from cache", fg='cyan')
        Reporter.display(cached_result['package'], cached_result['score'], cached_result['data'], is_cached=True)
        return

    scanner = Scanner(package, ecosystem)
    with click.progressbar(length=3, label='Scanning package...') as bar:
        data = scanner.fetch_all()
        bar.update(1)
        scorer = Scorer(data)
        score_info = scorer.calculate()
        bar.update(1)
        cache.save(package, ecosystem, score_info['score'], data)
        bar.update(1)

    Reporter.display(package, score_info, data)

@main.command()
def report():
    """Show the last scan report."""
    cache = Cache()
    last = cache.get_last()
    if last:
        Reporter.display(last['package'], last['score'], last['data'], is_cached=True)
    else:
        click.echo("No recent reports found.")

@main.command()
def install():
    """Wrapper for pip install with auto-scan."""
    click.echo("Implementation pending: use standard pip for now.")

@main.group()
def cache():
    """Manage local cache."""
    pass

@cache.command(name='clear')
def cache_clear():
    """Clear the local scan cache."""
    Cache().clear()
    click.echo("Cache cleared.")

if __name__ == '__main__':
    main()
